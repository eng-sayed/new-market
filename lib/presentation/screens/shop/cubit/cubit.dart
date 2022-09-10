import 'dart:developer';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/models/categories/categories_model.dart';
import '../../../../domain/models/product/wooproduct.dart';
import '../../../../domain/models/product_suggestion/suggestions.dart';
import '../../../../domain/repository/home_repo/home_repo.dart';
import '../../filter/filter_and_search_screen.dart';
import 'states.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitial());
  static ShopCubit get(context) => BlocProvider.of(context);
  PagingController<int, WooProduct> pagingController =
      PagingController<int, WooProduct>(firstPageKey: 1);

  fetchPage(
    BuildContext context, {
    required int pageKey,
    bool? onsale,
    int? catId,
  }) async {
    var newList =
        await getProducts(context, pageKey, categoryID: catId, onSale: onsale);

    if (newList != null) {
      var isLastPage = newList.isEmpty;

      if (isLastPage) {
        // stop
        pagingController.appendLastPage(newList ?? []);
      } else {
        // increase count to reach new page
        var nextPageKey = pageKey + 1;
        pagingController.appendPage(newList ?? [], nextPageKey);
      }
    }
  }

  getProducts(context, int Page,
      {int? categoryID, bool? onSale, List<int>? include}) async {
    if (Page == 1) {
      emit(ShopFirstLoadingState());
    }
    final response = await HomeRepository.getProduct(context,
        page: Page,
        categorie: categoryID,
        onSale: onSale,
        maxPrice: searchModel.rangeValues != null
            ? searchModel.rangeValues!.end.toString()
            : null,
        minPrice: searchModel.rangeValues != null
            ? searchModel.rangeValues!.start.toString()
            : null,
        incloud: include,
        search: searchModel.searchtext,
        orderBy: (searchModel.sortstate == Sortstate.priceMTH ||
                searchModel.sortstate == Sortstate.priceHTM)
            ? "price"
            : "date",
        perPage: include != null ? 100 : null,
        order: searchModel.sortstate == Sortstate.priceHTM ? "desc" : "asc");
    if (response != null) {
      emit(ShopGetAdsSuccessState());
      return response;
    } else {}
  }

  SearchModel searchModel = SearchModel();
  List<ProductSearchSuggestion> searchSuggestions = [];
  getSuggesstions(context, text) async {
    final response = await HomeRepository.searchSuggestion(context, text);
    if (response != null) {
      searchSuggestions = response;
      emit(ShopSuggesttionSuccessState());
    }
  }
}
