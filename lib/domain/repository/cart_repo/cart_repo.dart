import 'package:flutter/material.dart';

import '../../../core/utils/utils.dart';
import '../../../data/sources/api/dio.dart';
import '../../../data/sources/hive/local_hive.dart';
import '../../endpoints/endpoint.dart';
import '../../models/cart/woocart.dart';
import '../../models/product/wooproduct.dart';

class CartRepo {
  static Future<WooCart?> getCart({
    required BuildContext context,
  }) async {
    if (Utiles.token.isNotEmpty) {
      final response = await DioHelper.getData(context,
          url: EndPoins.URL_STORE_API_PATH + 'cart',
          // loading: true,
          token: Utiles.token);
      if (response != null) {
        Utiles.x_WC_Store =
            response.headers.value("x-wc-store-api-nonce") ?? "";
        return WooCart.fromJson(response.data);
      } else {
        return null;
      }
    } else {
      List<WooCartitems>? localItems = [];
      double totalCartPrice = 0.0;
      int count = 0;
      HiveLocal.localCart!.values.forEach((element) {
        final model = WooCartitems.fromJson(element);
        localItems.add(model);
        totalCartPrice +=
            double.parse(model.wooItemPrices!.price!) * model.quantity!;
        count += model.quantity!;
      });
      localItems;
      return WooCart(
          itemsCount: count,
          wooCartitems: localItems,
          cartTotals: CartTotals(
              totalPrice: totalCartPrice.toString(), totalShipping: "10"));
    }
  }

  static uploadToCart(context,
      {required int productID, required quantity}) async {
    if (Utiles.token.isNotEmpty) {
      final response = await DioHelper.postData(context,
          loading: true,
          body: {
            "id": productID,
            "quantity": quantity,
          },
          url: EndPoins.URL_STORE_API_PATH + 'cart/items',
          token: Utiles.token);
      if (response != null) {
        return true;
      }
    }
  }

  static addToCart(context,
      {required WooProduct product, required quantity}) async {
    if (Utiles.token.isNotEmpty) {
      final response = await DioHelper.postData(context,
          loading: true,
          body: {
            "id": product.id,
            "quantity": quantity,
          },
          url: EndPoins.URL_STORE_API_PATH + 'cart/items',
          token: Utiles.token);
      if (response != null) {
        return true;
      } else {
        return null;
      }
    } else {
      final selectedProduct = HiveLocal.localCart!.get(product.id);
      if (selectedProduct == null) {
        await HiveLocal.localCart!.put(
            product.id,
            WooCartitems(
                    name: product.name,
                    id: product.id,
                    quantity: quantity,
                    wooItemPrices: WooItemPrices(
                        regularPrice: product.price,
                        price: product.price,
                        salePrice: product.salePrice ?? ""),
                    wooCartItemImages: product.images)
                .toJson());
        return true;
      } else {
        WooCartitems model = WooCartitems.fromJson(selectedProduct);
        HiveLocal.localCart!.put(
            product.id,
            WooCartitems(
                    name: product.name,
                    id: product.id,
                    quantity: quantity + model.quantity!,
                    wooItemPrices: WooItemPrices(
                        price: product.price, salePrice: product.salePrice),
                    wooCartItemImages: product.images)
                .toJson());
        return true;
      }
    }
  }

  static updateToCart(context,
      {required id,
      required WooCartitems product,
      required quantity,
      required key}) async {
    if (Utiles.token.isNotEmpty) {
      final response = await DioHelper.putData(context,
          loading: true,
          body: {
            "id": id,
            "key": key,
            "quantity": quantity,
          },
          url: EndPoins.URL_STORE_API_PATH + 'cart/items/$key',
          token: Utiles.token);
      if (response != null) {
        return true;
      } else {
        return null;
      }
    } else {
      await HiveLocal.localCart!.put(
          product.id,
          WooCartitems(
                  name: product.name,
                  id: product.id,
                  quantity: quantity,
                  wooItemPrices: product.wooItemPrices,
                  wooCartItemImages: product.wooCartItemImages)
              .toJson());
      return true;
    }
  }

  static deleteItemCart(context, {required key, required id}) async {
    if (Utiles.token.isNotEmpty) {
      final response = await DioHelper.deleteData(context,
          url: EndPoins.URL_STORE_API_PATH + 'cart/items/$key',
          loading: true,
          token: Utiles.token);
      if (response != null) {
        return true;
      } else {
        return null;
      }
    } else {
      HiveLocal.localCart!.delete(id);
      return true;
    }
  }

  static deleteAllCart(
    context,
  ) async {
    final response = await DioHelper.deleteData(context,
        url: EndPoins.URL_STORE_API_PATH + 'cart/items/', token: Utiles.token);
    HiveLocal.localCart!.clear();
    if (response != null) {
      return true;
    } else {
      return null;
    }
  }
}
