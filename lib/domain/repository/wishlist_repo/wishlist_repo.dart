import 'dart:convert';

import '../../../core/utils/utils.dart';
import '../../../data/sources/api/dio.dart';
import '../../../data/sources/hive/local_hive.dart';
import '../../../data/sources/local/sharedpreferences.dart';
import '../../endpoints/endpoint.dart';
import '../../models/product/wooproduct.dart';
import '../../models/wishlist/woowishlist.dart';

class WishlistReposotry {
  static getWishlistKey(context) async {
    final response = await DioHelper.getData(context,
        url: EndPoins.DEFAULT_WC_API_PATH +
            'wishlist/get_by_user/${Utiles.UserId}',
        query: {
          "consumer_key": "ck_d5f8649bb3448e0c9361b9decff736ca82f33c32",
          "consumer_secret": "cs_52fd8dad5bacf1642721be6a7abf1fbf8a40ddce"
        });
    if (response != null) {
      Utiles.wishListKey = response.data.first["share_key"];
      CacheHelper.saveData(key: "share_key", value: Utiles.wishListKey);

      return true;
    }
  }

  static deletWishList(context,
      {required int productID, required String wishListid}) async {
    if (Utiles.token.isNotEmpty) {
      final response = await DioHelper.getData(context,
          loading: true,
          url: EndPoins.DEFAULT_WC_API_PATH +
              'wishlist/remove_product/$wishListid',
          token: Utiles.token);
      if (response != null) {
        return true;
      }
    } else {
      HiveLocal.localWishList!.delete(productID);
      return true;
    }
  }

  static addToWishList(context, WooProduct product) async {
    if (Utiles.token.isNotEmpty) {
      Utiles.wishListKey.isEmpty ? await getWishlistKey(context) : null;
      final response = await DioHelper.postData(context,
          loading: true,
          url: EndPoins.DEFAULT_WC_API_PATH +
              'wishlist/${Utiles.wishListKey}/add_product',
          query: {
            "consumer_key": "ck_d5f8649bb3448e0c9361b9decff736ca82f33c32",
            "consumer_secret": "cs_52fd8dad5bacf1642721be6a7abf1fbf8a40ddce"
          },
          token: Utiles.token,
          body: {'product_id': product.id.toString()});
      if (response != null) {
        return WishListItem.fromJson(response.data.first);
      }
    } else {
      HiveLocal.localWishList!.put(
          product.id,
          WishListItem(
                  image:
                      product.images!.isEmpty ? "" : product.images!.first.src,
                  productId: product.id,
                  price: product.regularPrice,
                  saLePrice: product.salePrice,
                  onSale: product.onSale,
                  inStock: product.stockStatus == "instock",
                  name: product.name)
              .toJson());
      return true;
    }
  }

  static Future<WooWishList?> getWishlist(context) async {
    if (Utiles.token.isNotEmpty) {
      Utiles.wishListKey.isEmpty ? await getWishlistKey(context) : null;

      final response = await DioHelper.getData(context,
          url: EndPoins.DEFAULT_WC_API_PATH +
              'wishlist/${Utiles.wishListKey}/get_products',
          query: {
            "consumer_key": "ck_d5f8649bb3448e0c9361b9decff736ca82f33c32",
            "consumer_secret": "cs_52fd8dad5bacf1642721be6a7abf1fbf8a40ddce"
          });
      if (response != null) {
        return WooWishList.fromJson({"WishList": response.data});
      } else {
        return null;
      }
    } else {
      List<WishListItem> items = [];
      HiveLocal.localWishList!.values.forEach((element) {
        items.add(WishListItem.fromJson(element));
      });
      return WooWishList(wishList: items);
    }
  }
}
