import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/utils.dart';
import '../../../data/sources/api/dio.dart';
import '../../../data/sources/hive/local_hive.dart';
import '../../endpoints/endpoint.dart';
import '../../models/customer/customer.dart';
import '../../models/jwt/jwt.dart';
import '../../models/user/user_model.dart';
import '../../requests/forget_password/forget_pass_request.dart';
import '../../requests/register_request/register_request.dart';

class AuthRepository {
  static const String consumerKey =
      'ck_d5f8649bb3448e0c9361b9decff736ca82f33c32';
  static const String consumerSecret =
      'cs_52fd8dad5bacf1642721be6a7abf1fbf8a40ddce';
  static Future<WooCustomer?> getUserData({
    required BuildContext context,
  }) async {
    final response1 = await DioHelper.getData(context,
        url: EndPoins.URL_USER_ME, token: Utiles.token, loading: true);

    if (response1 != null) {
      return WooCustomer.fromJson(response1.data);
    } else {
      return null;
    }
  }

  static Future<WooCustomer?> login({
    required BuildContext context,
    required String username,
    required String password,
  }) async {
    final response = await DioHelper.postData(context,
        url: '/wp-json/jwt-auth/v1/token',
        loading: true,
        query: {
          "consumer_key": AuthRepository.consumerKey,
          "consumer_secret": AuthRepository.consumerSecret
        },
        body: {
          "username": username,
          "password": password,
        });
    if (response != null) {
      Utiles.token = response.data["token"];
      Utiles.Username = response.data["user_display_name"].toString();

      final userDataResponse = await DioHelper.getData(
        context,
        url: EndPoins.URL_USER_ME,
        loading: true,
        token: Utiles.token,
        query: {
          "consumer_key": AuthRepository.consumerKey,
          "consumer_secret": AuthRepository.consumerSecret
        },
      );

      //http.get(Uri.parse(this.baseUrl + URL_USER_ME), headers: _urlHeader);

      Utiles.UserId = userDataResponse!.data["id"].toString();

      final customer = await getUserData(context: context);
      if (customer != null) {
        return WooCustomer.fromJson(response.data);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<WooCustomer?> getCustomerData({
    required BuildContext context,
    required String Id,
  }) async {
    final response = await DioHelper.getData(
      context,
      url: EndPoins.DEFAULT_WC_API_PATH + 'customers/$Id',
      query: {
        "consumer_key": AuthRepository.consumerKey,
        "consumer_secret": AuthRepository.consumerSecret
      },
    );
    if (response != null) {
      return WooCustomer.fromJson(response.data);
    } else {
      return null;
    }
  }

  static Future<WooCustomer?> register({
    required BuildContext context,
    required WooCustomer registerRequest,
  }) async {
    final response = await DioHelper.postData(context,
        url: EndPoins.DEFAULT_WC_API_PATH + 'customers',
        loading: true,
        query: {"consumer_key": consumerKey, "consumer_secret": consumerSecret},
        body: registerRequest.toJson());
    if (response != null) {
      return WooCustomer.fromJson(response.data);
    } else {
      return null;
    }
  }

  static Future<WooCustomer?> updateUserData({
    required BuildContext context,
    required WooCustomer registerRequest,
  }) async {
    final response = await DioHelper.putData(context,
        url: EndPoins.DEFAULT_WC_API_PATH + 'customers/${Utiles.UserId}',
        loading: true,
        body: registerRequest.toJson(),
        query: {
          "consumer_key": consumerKey,
          "consumer_secret": consumerSecret
        });
    if (response != null) {
      return WooCustomer.fromJson(response.data);
    } else {
      return null;
    }
  }

  static Future<bool?> forgetPassword({
    required BuildContext context,
    required String email,
  }) async {
    final response = await DioHelper.getData(context,
        url: EndPoins.forgetPass, loading: true, query: {"login": email});
    if (response!.data['code'] == '101') {
      return false;
    } else {
      return true;
    }
  }

  static Future<UserModel?> restPassword({
    required BuildContext context,
    required ForgetPassRequest forgetPassRequest,
  }) async {
    final response = await DioHelper.postData(context,
        url: EndPoins.restPass,
        loading: true,
        body: forgetPassRequest.toJson());
    if (response != null) {
      return UserModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  static Future<UserModel?> vertfyNumber({
    required BuildContext context,
    required String code,
    required String phone,
  }) async {
    final response = await DioHelper.postData(context,
        url: EndPoins.restPass,
        loading: true,
        body: {
          "code": code,
          "phone": phone,
        });
    if (response != null) {
      return UserModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  static Future<WooCustomer?> deleteUserData(
      {required BuildContext context, required String customerId}) async {
    final response1 = await DioHelper.deleteData(context,
        url: EndPoins.DEFAULT_WC_API_PATH + EndPoins.deleteCustomer(customerId),
        query: {
          "consumer_key": consumerKey,
          "consumer_secret": consumerSecret,
          "force": true
        },
        token: Utiles.token,
        loading: true);

    if (response1 != null) {
      return WooCustomer.fromJson(response1.data);
    } else {
      return null;
    }
  }

  static Future<String?> sendOtp({
    required BuildContext context,
    required String phone,
  }) async {
    final response = await DioHelper.postData(context,
        url: EndPoins.restPass,
        loading: true,
        body: {
          "phone": phone,
        });
    if (response != null) {
      return response.data['data']["code"];
    } else {
      return null;
    }
  }
}
