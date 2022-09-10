import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_lampa/presentation/screens/home/cubit/cubit.dart';

import '../../../../core/utils/alerts.dart';
import '../../../../core/utils/utils.dart';
import '../../../../domain/models/product/wooproduct.dart';
import '../../../../domain/models/wishlist/woowishlist.dart';
import '../../../../domain/repository/wishlist_repo/wishlist_repo.dart';
import '../../shop/cubit/cubit.dart';
import 'states.dart';

class FavouriteCubit extends Cubit<FavouriteStates> {
  FavouriteCubit() : super(FavouriteInitial());
  static FavouriteCubit get(context) => BlocProvider.of(context);
  List<WishListItem> wishList = [];
  List<WooProduct> wishListProducts = [];
  getWishliste(context) async {
    emit(FavouriteGetDataLoading());
    final respose = await WishlistReposotry.getWishlist(context);

    if (respose != null) {
      wishList = respose.wishList ?? [];
      print(wishList.map((e) => e.productId).toList());

      wishListProducts = await ShopCubit.get(context).getProducts(context, 1,
          include: wishList.map((e) => e.productId ?? 0).toList());
      emit(FavouriteGetDataSuccess());
    } else {
      emit(FavouriteGetDataError());
    }
  }

  toggleWhislist(
    context, {
    WooProduct? product,
    required int productId,
  }) async {
    emit(ToggelFavouriteLoagingState());
    if (wishList.any((element) => element.productId == productId)) {
      final wishListId = wishList
          .firstWhere((element) => element.productId == productId)
          .itemId;
      final response = await WishlistReposotry.deletWishList(context,
          productID: productId, wishListid: wishListId.toString());
      if (response != null) {
        wishList.removeWhere((element) => element.productId == productId);
        wishListProducts.removeWhere((element) => element.id == productId);
        OverLays.snack(context,
            text: "deletewishlist".tr(), state: SnakState.success);
        emit(ToggelFavouriteDoneState());

        return true;
      } else {
        OverLays.snack(context, text: "error".tr(), state: SnakState.failed);
        emit(ToggelFavouriteDoneState());

        return false;
      }
    } else {
      final response = await WishlistReposotry.addToWishList(context, product!);
      if (response != null) {
        if (Utiles.token.isNotEmpty) {
          wishList.add(response);
        } else {
          getWishliste(context);
        }
        OverLays.snack(context,
            text: "addwishlist".tr(), state: SnakState.success);
        emit(ToggelFavouriteDoneState());

        return true;
      } else {
        OverLays.snack(context, text: "error".tr(), state: SnakState.failed);
        emit(ToggelFavouriteDoneState());

        return false;
      }
    }
  }
}
