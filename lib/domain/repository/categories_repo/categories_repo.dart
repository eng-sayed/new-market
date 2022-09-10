import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../data/sources/api/dio.dart';
import '../../endpoints/endpoint.dart';
import '../../models/categories/home_categories_model.dart';

class CategoriesRepository {
  static Future<HomeCategoriesModel?> getCategoriesData({
    required BuildContext context,
  }) async {
    final response = await DioHelper.getData(context, url: EndPoins.categories);
    if (response != null) {
      return HomeCategoriesModel.fromJson(response.data);
    } else {
      return null;
    }
  }
}
