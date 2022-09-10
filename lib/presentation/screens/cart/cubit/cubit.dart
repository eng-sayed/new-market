import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/alerts.dart';
import '../../../../data/sources/hive/local_hive.dart';
import '../../../../domain/models/cart/woocart.dart';
import '../../../../domain/models/product/wooproduct.dart';
import '../../../../domain/repository/cart_repo/cart_repo.dart';
import 'states.dart';

class CartCubit extends Cubit<CartStates> {
  CartCubit() : super(CartInitial());
  static CartCubit get(context) => BlocProvider.of(context);

  WooCart cart = WooCart();
  getDataCart({
    required BuildContext context,
  }) async {
    cart = WooCart();
    emit(CartGetDataLoading());
    var response = await CartRepo.getCart(context: context);
    if (response != null) {
      cart = response;
      emit(CartGetDataSuccess());
    } else {
      emit(CartGetDataError());
    }
  }

  addToCart(context,
      {required WooProduct product, required int quantity}) async {
    final resposne =
        await CartRepo.addToCart(context, product: product, quantity: quantity);
    if (resposne != null) {
      OverLays.snack(context, text: "addcart".tr(), state: SnakState.success);
    } else {
      OverLays.snack(context, text: "error".tr(), state: SnakState.failed);
    }
  }

  removeFromCart(context, {required String key, required int id}) async {
    emit(CartGetDataLoading());

    final resposne = await CartRepo.deleteItemCart(context, key: key, id: id);
    if (resposne != null) {
      // OverLays.snack(context,
      //     text: "deletecart".tr(), state: SnakState.success);
      cart.wooCartitems!.removeWhere((element) => element.id == id);

      emit(CartRemoveFromCartSuccess());
      OverLays.snack(context,
          text: "deletecart".tr(), state: SnakState.success);
    } else {
      OverLays.snack(context, text: "error".tr(), state: SnakState.failed);
    }
  }

  deleteAllCart(context) async {
    final resposne = await CartRepo.deleteAllCart(
      context,
    );
    if (resposne != null) {
      OverLays.snack(context,
          text: "تمت افراغ بنجاح", state: SnakState.success);
    } else {
      OverLays.snack(context, text: "error".tr(), state: SnakState.failed);
    }
  }

  updateCartItem(context,
      {required String key,
      required int id,
      required WooCartitems product,
      required int quantity}) async {
    final resposne = await CartRepo.updateToCart(context,
        key: key, id: id, product: product, quantity: quantity);
    if (resposne != null) {
      OverLays.snack(context, text: "addcart".tr(), state: SnakState.success);
      cart.wooCartitems!
          .firstWhere((element) => element.id == product.id,
              orElse: (() => WooCartitems()))
          .quantity = quantity;
      emit(CartAddToCartSuccess());
    } else {
      OverLays.snack(context, text: "error".tr(), state: SnakState.failed);
    }
  }

  String cartTotal() {
    double total = 0;
    cart.wooCartitems?.forEach((element) {
      total +=
          double.parse(element.wooItemPrices?.price ?? "0") * element.quantity!;
    });
    return total.toStringAsFixed(2);
  }

  uploadCartItems(context) async {
    emit(UploadCartGetLoading());
    await getDataCart(context: context);
    for (var item in HiveLocal.localCart!.values.toList()) {
      final model = WooCartitems.fromJson(item);

      return await CartRepo.uploadToCart(context,
          productID: model.id ?? 0, quantity: model.quantity);
    }
    emit(UploadCartGetSuccess());
  }
}
