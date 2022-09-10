import 'package:flutter/material.dart';

import '../../../core/utils/utils.dart';
import '../../../data/sources/api/dio.dart';
import '../../endpoints/endpoint.dart';
import '../../models/category/woocategory.dart';
import '../../models/product/wooproduct.dart';
import '../../models/product_suggestion/suggestions.dart';
import '../../models/wooslider.dart/wooslider.dart';
import '../auth_repo/auth_repostory.dart.dart';

class HomeRepository {
  static Future<List<WooProduct>?> getProduct(context,
      {int page = 1,
      String? search,
      String? orderBy,
      String? maxPrice,
      bool? onSale,
      perPage = 50,
      String? minPrice,
      List<int>? incloud,
      String? order,
      int? categorie,
      bool? featured}) async {
    Map<String, dynamic> payload = {
      "consumer_key": AuthRepository.consumerKey,
      "consumer_secret": AuthRepository.consumerSecret
    };

    ({
      'page': page,
      'per_page': perPage,
      'search': search,
      'order': order,
      'orderby': orderBy,
      'featured': featured,
      'category': categorie,
      "status": "publish",
      'on_sale': onSale,
      'min_price': minPrice,
      "include": incloud,
      'max_price': maxPrice,
    }).forEach((k, v) {
      if (v != null) payload[k] = v.toString();
    });
    final response = await DioHelper.getData(context,
        base: Utiles.apiUrl + EndPoins.DEFAULT_WC_API_PATH,
        url: "products",
        query: payload);
    //  products.addAll(theResposne);
    if (response != null) {
      List<WooProduct> list = [];
      for (var o in response.data) {
        var order = WooProduct.fromJson(o);
        list.add(order);
      }
      return list;
    }

    return null;
  }

  static Future<List<WooProductCategory>?> getCategory(
    context, {
    int page = 1,
    String? search,
    String? orderBy,
  }) async {
    Map<String, dynamic> payload = {};

    ({
      'page': page,
      'per_page': 100,
      'search': search,
      'orderby': orderBy,
      'hide_empty': true,
      'parent': 0,
    }).forEach((k, v) {
      if (v != null) payload[k] = v.toString();
    });
    final response = await DioHelper.getData(context,
        base: Utiles.apiUrl, url: "category", query: payload);
    //  products.addAll(theResposne);
    if (response != null) {
      List<WooProductCategory> list = [];
      for (var o in response.data) {
        var order = WooProductCategory.fromJson(o);
        list.add(order);
      }
      return list;
    }

    return null;
  }

  static Future<List<WooProductCategory>?> getSubCategory(
    context, {
    int page = 1,
    String? search,
    String? orderBy,
    int? parent,
  }) async {
    Map<String, dynamic> payload = {};

    ({
      'page': page,
      'per_page': 100,
      'search': search,
      'orderby': orderBy,
      'hide_empty': true,
      'parent': parent,
    }).forEach((k, v) {
      if (v != null) payload[k] = v.toString();
    });
    final response = await DioHelper.getData(context,
        base: Utiles.apiUrl, url: "category", query: payload);
    //  products.addAll(theResposne);
    if (response != null) {
      List<WooProductCategory> list = [];
      for (var o in response.data) {
        var order = WooProductCategory.fromJson(o);
        list.add(order);
      }
      return list;
    }

    return null;
  }

  static Future<WooProduct?> singelProduct(context, String id) async {
    final response = await DioHelper.getData(context,
        base: Utiles.apiUrl + EndPoins.DEFAULT_WC_API_PATH,
        url: "products/$id",
        query: {
          "consumer_key": AuthRepository.consumerKey,
          "consumer_secret": AuthRepository.consumerSecret
        });
    //  products.addAll(theResposne);
    if (response != null) {
      return WooProduct.fromJson(response.data);
    }
  }

  static Future<Map<String, dynamic>?> homeRequest(context) async {
    final response = await DioHelper.getData(context,
        base: Utiles.apiUrl + EndPoins.DEFAULT_WC_API_PATH,
        url: "products",
        query: {
          "consumer_key": AuthRepository.consumerKey,
          "consumer_secret": AuthRepository.consumerSecret
        });
    // List<WooProduct> featuerdProduct = [];
    // List<WooMobileSlider> sliders = [];
    List<WooProduct> shop = [];
    // List<WooProductCategory> cat = [];
    //  products.addAll(theResposne);
    if (response != null) {
      // (response.data ?? []).forEach((element) {
      //   featuerdProduct.add(WooProduct.fromJson(element));
      //   print(element.toString());
      // });
      (response.data ?? []).forEach((element) {
        shop.add(WooProduct.fromJson(element));
        print(element.toString());
      });
      // (response.data["cat"] ?? []).forEach((element) {
      //   cat.add(WooProductCategory.fromJson(element));
      //   print(element.toString());
      // });
      // print(featuerdProduct.length);

      // (response.data["sliders"] ?? []).forEach((element) {
      //   sliders.add(WooMobileSlider.fromJson(element));
      // });
      //   print("xxxxxxxx" + featuerdProduct.length.toString());
      return {
        // "featured": featuerdProduct,
        // "sliders": sliders,
        "shop": shop,
        // "cat": cat
      };
    }
  }

  static searchSuggestion(context, String text) async {
    if (text.isNotEmpty) {
      final response = await DioHelper.getData(context,
          base: Utiles.apiUrl, url: "search", query: {'text': text});

      List<ProductSearchSuggestion> suggestion = [];
      if (response != null) {
        response.data.forEach((element) =>
            suggestion.add(ProductSearchSuggestion.fromMap(element)));
        return suggestion;
      }
    }
  }
}
