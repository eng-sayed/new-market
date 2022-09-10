import 'dart:developer';

import 'package:new_lampa/core/utils/utils.dart';
import 'package:new_lampa/domain/models/order/wooorder.dart';
import 'package:new_lampa/domain/repository/order_repo/order_repo.dart';
import 'package:new_lampa/presentation/layout/layout.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'states.dart';

class OrdersCubit extends Cubit<OrdersStates> {
  OrdersCubit() : super(OrdersInitial());
  static OrdersCubit get(context) => BlocProvider.of(context);
  List<WooOrder> orders = [];
  getOrders(context) async {
    emit(OrdersGetDataLoading());
    final response = await OrderRepo.getOrders(context);

    if (response != null) {
      orders = response;
      emit(OrdersGetDataSuccess());
    } else {
      emit(OrdersGetDataError());
    }
  }
}
