import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/models/product/wooproduct.dart';
import '../../../../domain/repository/home_repo/home_repo.dart';
import 'states.dart';

class ProductScreenCubit extends Cubit<ProductScreenStates> {
  ProductScreenCubit() : super(ProductScreenInitial());
  static ProductScreenCubit get(context) => BlocProvider.of(context);

  Future<WooProduct?> getProductById(context, id) async {
    emit(ProductScreenPageGetAdsLoadingState());
    final response = await HomeRepository.singelProduct(context, id.toString());

    if (response != null) {
      emit(ProductScreenPageGetAdsSuccessState());

      return response;
    } else {
      emit(ProductScreenPageGetAdsErrorState());
    }
  }

  getRelatedProductBy(context, List<int> list) async {
    emit(ProductScreenPageGetAdsLoadingState());
    final response = await HomeRepository.getProduct(context, incloud: list);

    if (response != null) {
      emit(ProductScreenPageGetAdsSuccessState());

      return response;
    } else {
      emit(ProductScreenPageGetAdsErrorState());
    }
  }
}
