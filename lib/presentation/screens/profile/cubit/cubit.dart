import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_lampa/presentation/layout/layout.dart';
import 'package:new_lampa/presentation/screens/home/home.dart';

import '../../../../core/utils/alerts.dart';
import '../../../../core/utils/utils.dart';
import '../../../../domain/models/customer/customer.dart';
import '../../../../domain/models/order/wooorder_payload.dart';
import '../../../../domain/models/zones/shippingzone.dart';
import '../../../../domain/models/zones/zone_model.dart';
import '../../../../domain/repository/auth_repo/auth_repostory.dart.dart';
import '../../../layout/drawer_layout.dart';
import '../../../shared/navigator.dart';
import 'states.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileInitial());
  static ProfileCubit get(context) => BlocProvider.of(context);
  TextEditingController firstNameBilling = TextEditingController();
  TextEditingController lastNameBilling = TextEditingController();
  TextEditingController emailBilling = TextEditingController();
  TextEditingController adressBilling = TextEditingController();
  TextEditingController adressShipping = TextEditingController();
  //  TextEditingController postCodeBilling;
  TextEditingController phoneNumberBilling = TextEditingController();
  List<WooZonesModel> zones = [];
  getUserDate(context) async {
    emit(GetCustomerDataLoadingState());
    final response = await AuthRepository.getCustomerData(
        context: context, Id: Utiles.UserId);

    if (response != null) {
      firstNameBilling.text = response.firstName ?? "";
      lastNameBilling.text = response.lastName ?? "";
      emailBilling.text = response.email ?? "";
      adressBilling.text = response.billing?.address1 ?? "";
      phoneNumberBilling.text = response.billing?.phone ?? "";

      adressShipping.text = response.shipping?.address1 ?? "";

      emit(GetCustomerDataSuccessState());
    } else {
      emit(GetCustomerDataErrorState());
    }
  }

  updateUserData(context) async {
    emit(UpdateCustomerDataLoadingState());
    final response = await AuthRepository.updateUserData(
        context: context,
        registerRequest: WooCustomer(
          firstName: firstNameBilling.text,
          lastName: lastNameBilling.text,
          email: emailBilling.text,
          billing: Billing(
            address1: adressBilling.text,
            phone: "966" + phoneNumberBilling.text,
            firstName: firstNameBilling.text,
            lastName: lastNameBilling.text,
          ),
        ));
    if (response != null) {
      emit(UpdateCustomerDataSuccessState());
      OverLays.snack(context,
          text: "تم تعديل البيانات بنجاح", state: SnakState.success);
    } else {
      emit(UpdateCustomerDataErrorState());
    }
  }

  updateUserPassword(context, String password) async {
    emit(UpdateCustomerDataLoadingState());
    final response = await AuthRepository.updateUserData(
        context: context,
        registerRequest: WooCustomer(
          password: password,
        ));
    if (response != null) {
      Utiles.logout();
      navigateReplacement(context: context, route: HomePage());
      emit(UpdateCustomerDataSuccessState());
    } else {
      emit(UpdateCustomerDataErrorState());
    }
  }

  deleteUser(context) async {
    emit(DeleteCustomerDataLoadingState());
    final response = await AuthRepository.deleteUserData(
        context: context, customerId: Utiles.UserId);
    if (response != null) {
      Utiles.logout();
      navigateReplacement(context: context, route: HomeLayout());
      emit(DeleteCustomerDataSuccessState());
    } else {
      OverLays.snack(context, text: "error".tr(), state: SnakState.failed);
      emit(DeleteCustomerDataErrorState());
    }
  }
}
