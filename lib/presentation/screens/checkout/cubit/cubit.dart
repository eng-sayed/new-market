import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/alerts.dart';
import '../../../../core/utils/utils.dart';
import '../../../../domain/models/cart/woocart.dart';
import '../../../../domain/models/order/wooorder_payload.dart';
import '../../../../domain/models/zones/shippingzone.dart';
import '../../../../domain/models/zones/zone_model.dart';
import '../../../../domain/repository/auth_repo/auth_repostory.dart.dart';
import '../../../../domain/repository/order_repo/order_repo.dart';
import '../../cart/cubit/cubit.dart';
import 'states.dart';

class CheckOutCubit extends Cubit<CkeckoutStates> {
  CheckOutCubit() : super(CkeckoutInitial());
  static CheckOutCubit get(context) => BlocProvider.of(context);
  TextEditingController firstNameBilling = TextEditingController();
  TextEditingController lastNameBilling = TextEditingController();
  TextEditingController emailBilling = TextEditingController();
  TextEditingController adressBilling = TextEditingController();
  TextEditingController phoneNumberBilling = TextEditingController();
  TextEditingController firstNameShipping = TextEditingController();
  TextEditingController lastNameShipping = TextEditingController();
  TextEditingController emailShipping = TextEditingController();
  TextEditingController adressShipping = TextEditingController();
  TextEditingController phoneNumberShipping = TextEditingController();
  TextEditingController notes = TextEditingController();
  List<WooZonesModel> zones = [];
  iniOrderScreen(context) async {
    emit(GetCustomerDataLoadingState());
    final response = await AuthRepository.getCustomerData(
        context: context, Id: Utiles.UserId);
    final response2 = await OrderRepo.getZones(context);
    if (response != null && response2 != null) {
      firstNameBilling.text = response.firstName ?? "";
      lastNameBilling.text = response.lastName ?? "";
      emailBilling.text = response.email ?? "";
      adressBilling.text = response.billing?.address1 ?? "";
      phoneNumberBilling.text = response.billing?.phone ?? "";
      firstNameShipping.text = response.firstName ?? "";
      lastNameShipping.text = response.lastName ?? "";
      emailShipping.text = response.email ?? "";
      adressShipping.text = response.shipping?.address1 ?? "";
      zones = response2;
      emit(GetCustomerDataSuccessState());
    } else {
      emit(GetCustomerDataErrorState());
    }
  }

  List<WooShippingZoneMethod> methods = [];
  selectShippingMethode(context, id) async {
    final response = await OrderRepo.getShippingforZone(context, id);
    if (response != null) {
      methods = response;

      emit(GetShippingMethodeSuccessState());
    } else {
      emit(GetShippingMethodeErrorState());
    }
  }

  WooZonesModel? selectedZone;
  WooZonesModel? selectedZoneShipping;
  WooShippingZoneMethod? shippingZoneMethod;
  WooShippingZoneMethod? billingShippingZoneMethod;
  createOrder(bool shipping, List<WooCartitems> items) {
    return WooOrderPayload(
        customerNote: notes.text,
        customerId: int.parse(Utiles.UserId),
        status: "processing",
        paymentMethod: "cod",
        paymentMethodTitle: "Cash on delivery",
        shippingLines: [
          shipping
              ? ShippingLines(
                  total: shippingZoneMethod!.settings!.cost!.value!,
                  methodId: shippingZoneMethod!.methodId!,
                  methodTitle:
                      billingShippingZoneMethod!.settings!.title!.value!)
              : ShippingLines(
                  total: billingShippingZoneMethod!.settings!.cost!.value!,
                  methodId: billingShippingZoneMethod!.methodId!,
                  methodTitle:
                      billingShippingZoneMethod!.settings!.title!.value!)
        ],
        billing: WooOrderPayloadBilling(
            firstName: firstNameBilling.text,
            lastName: lastNameBilling.text,
            email: emailBilling.text,
            address1: adressBilling.text,
            phone: phoneNumberBilling.text,
            city: selectedZone!.locationCode!.tr(),
            country: "Egypt"),
        shipping: shipping
            ? WooOrderPayloadShipping(
                firstName: firstNameShipping.text,
                lastName: lastNameShipping.text,
                address1: adressShipping.text,
                //   city: selectedzodeShipping!.locationCode!.tr(),
                country: "Egypt")
            : WooOrderPayloadShipping(
                firstName: firstNameBilling.text,
                lastName: lastNameBilling.text,
                address1: adressBilling.text,
                country: "Egypt",
                city: selectedZone!.locationCode!.tr()),
        lineItems: items
            .map((e) => LineItems(productId: e.id, quantity: e.quantity))
            .toList());
  }

  sendOrder(context, bool shipping, List<WooCartitems> items) async {
    emit(SendOrderLoadingState());
    final orderbayload = createOrder(shipping, items);
    final response =
        await OrderRepo.createOrder(context, orderPayload: orderbayload);
    if (response != null) {
      emit(SendOrderSuccessState());
      OverLays.snack(context, text: "addorder".tr(), state: SnakState.success);
      CartCubit.get(context).deleteAllCart(context);
      Navigator.popUntil(context, (route) => route.isFirst);
    } else {
      emit(SendOrderErrorState());
    }
  }
}
