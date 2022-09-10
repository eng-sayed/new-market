import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/models/category/woocategory.dart';
import '../../../../domain/repository/home_repo/home_repo.dart';
import 'states.dart';

class CategoriesCubit extends Cubit<CategoriesStates> {
  CategoriesCubit() : super(CategoriesInitial());
  static CategoriesCubit get(context) => BlocProvider.of(context);

  List<WooProductCategory> categories = [];
  getDataCategories({
    required BuildContext context,
  }) async {
    categories = [];
    emit(CategoriesPageGetAdsLoadingState());
    var response = await HomeRepository.getCategory(context);
    if (response != null) {
      categories = response;
      selectedId = categories.first.id ?? 0;
      log('categories' + categories.length.toString());
      emit(CategoriesPageGetAdsSuccessState());
    } else {
      emit(CategoriesPageGetAdsErrorState());
    }
  }

  List<WooProductCategory> subCategories = [];
  int selectedId = 0;
  getDataSubCategories({
    required BuildContext context,
  }) async {
    subCategories = [];
    emit(SubCategoriesPageGetAdsLoadingState());
    var response =
        await HomeRepository.getSubCategory(context, parent: selectedId);
    if (response != null) {
      subCategories = response;
      if (subCategories.isEmpty) {
        final cat =
            categories.firstWhere((element) => element.id == selectedId);
        subCategories.add(cat);
      }

      log('subCategories' + subCategories.length.toString());
      emit(SubCategoriesPageGetAdsSuccessState());
    } else {
      emit(SubCategoriesPageGetAdsErrorState());
    }
  }
}
