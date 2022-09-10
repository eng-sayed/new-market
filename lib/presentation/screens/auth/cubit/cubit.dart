import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_lampa/presentation/screens/auth/cubit/state.dart';
import 'package:new_lampa/presentation/screens/home/home.dart';

import '../../../../core/utils/alerts.dart';
import '../../../../core/utils/utils.dart';
import '../../../../data/sources/hive/local_hive.dart';
import '../../../../data/sources/local/sharedpreferences.dart';
import '../../../../domain/models/customer/customer.dart';
import '../../../../domain/repository/auth_repo/auth_repostory.dart.dart';
import '../../../../domain/requests/forget_password/forget_pass_request.dart';
import '../../../componants/upload_cart.dart';
import '../../../layout/drawer_layout.dart';
import '../../../layout/layout.dart';
import '../../../shared/navigator.dart';
import '../screens/auth_screen.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of(context);

  regiser(context, {required WooCustomer customer}) async {
    // emit(RegisterLoadingState());
    final response = await AuthRepository.register(
        context: context, registerRequest: customer);
    if (response != null) {
      Navigator.pop(context);
      navigate(context: context, route: AuthScreen());
      OverLays.snack(context,
          state: SnakState.success, text: "register success".tr());

      emit(RegisterSuccessState());
      return true;
    } else {
      Navigator.pop(context);

      emit(RegisterErrorState());
      return false;
    }
  }

  // sendOtp(context) async {
  //   final response = await AuthRepository.sendOtp(
  //       context: context, phone: registerRequest.phone ?? "");
  //   if (response != null) {
  //     emit(SendOtpSuccessState());
  //   } else {
  //     emit(SendOtpErrorState());
  //   }
  // }

  saveToken() {
    CacheHelper.saveData(key: "token", value: Utiles.token);
    CacheHelper.saveData(key: "userid", value: Utiles.UserId);
    CacheHelper.saveData(key: "username", value: Utiles.Username);
  }

  login(
    context, {
    required String username,
    required String password,
  }) async {
    // emit(LoginLoadingState());
    final response = await AuthRepository.login(
      context: context,
      username: username,
      password: password,
    );

    if (response != null) {
      HiveLocal.localCart!.isEmpty
          ? // navigateReplacement(context: context, route: Home())
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => HomeLayout()),
              (route) => false)
          : showDialog(context: context, builder: (context) => UploadCart());
      navigateReplacement(context: context, route: HomeLayout());
      saveToken();
      emit(LoginSuccessState());
    } else {
      emit(LoginErrorState());
    }
  }

  ForgetPassRequest forgetPassRequest = ForgetPassRequest();
  forgetPassword(context, String email) async {
    final response =
        await AuthRepository.forgetPassword(context: context, email: email);
    if (response == true) {
      emit(ForgotPasswordSuccessState());
      OverLays.snack(context,
          text: "restpasssent".tr(), state: SnakState.success);
    } else {
      OverLays.snack(context, text: "notfndusr".tr(), state: SnakState.failed);

      emit(ForgotPasswordErrorState());
    }
  }

  restPassword(context) async {
    final response = await AuthRepository.restPassword(
        context: context, forgetPassRequest: forgetPassRequest);
    if (response != null) {
      emit(ResetPasswordSuccessState());
    } else {
      emit(ResetPasswordErrorState());
    }
  }
}
