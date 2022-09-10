import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:version/version.dart';

import '../../../../core/utils/utils.dart';
import '../../../../data/sources/api/dio.dart';
import '../../../../domain/models/categories/categories_model.dart';
import '../../../../domain/models/category/woocategory.dart' hide Image;
import '../../../../domain/models/product/wooproduct.dart';
import '../../../../domain/models/product_suggestion/suggestions.dart';
import '../../../../domain/models/wooslider.dart/wooslider.dart';
import '../../../../domain/repository/home_repo/home_repo.dart';
import '../../../componants/customtext.dart';
import '../../filter/filter_and_search_screen.dart';
import 'states.dart';

class HomePageCubit extends Cubit<HomePageStates> {
  HomePageCubit() : super(HomePageInitial());
  static HomePageCubit get(context) => BlocProvider.of(context);

  List<WooProduct> shop = [];
  List<WooMobileSlider> sliders = [];
  List<WooProduct> featuerd = [];
  List<WooProductCategory> cat = [];
  ScrollController shopController = ScrollController();
  int producpage = 1;

  PagingController<int, WooProduct> pagingController =
      PagingController<int, WooProduct>(firstPageKey: 1);

  SearchModel searchModel = SearchModel();
  List<ProductSearchSuggestion> searchSuggestions = [];
  getSuggesstions(context, text) async {
    final response = await HomeRepository.searchSuggestion(context, text);
    if (response != null) {
      searchSuggestions = response;
      emit(ShopSuggesttionSuccessState());
    }
  }

  getVersion(context) async {
    final respose = await DioHelper.mydio.get("app-api/public/api/version");
    print("v" + respose.data);
    final lastVersion = Version.parse(respose.data["version"]);
    final packageInfo = await PackageInfo.fromPlatform();
    final currentVersion = Version.parse(packageInfo.version);
    if (currentVersion < lastVersion) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
                title: Column(
                  children: [
                    Image.asset(
                      "assets/images/logo.png",
                      height: 100,
                    ),
                    CustomText("newupdate".tr()),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      launchUrl(Uri.parse(
                          "https://play.google.com/store/apps/details?id=com.reeras.lampatronics"));
                    },
                    child: CustomText("update".tr()),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: CustomText("close".tr()),
                  )
                ],
              ));
    }
  }

  getHomeData(context) async {
    producpage = 0;
    emit(HomePageGetAdsLoadingState());

    final response = await HomeRepository.homeRequest(context);
    if (response != null) {
      shop = response["shop"];
      //sliders = response["sliders"];
      // featuerd = response["featured"];
      // cat = response["cat"];
      getCatories();
      emit(HomePageGetAdsSuccessState());
    } else {
      HomePageGetAdsErrorState();
    }
  }

  getProducts(context) async {
    final response = await HomeRepository.getProduct(context, page: producpage);
    if (response != null) {
      shop.addAll(response);
      emit(HomePageGetProductsLoadingState());
    } else {
      HomePageGetProductsErrorState();
    }
  }

  paginateHome(context) async {
    producpage++;

    await getProducts(context);
  }

  List<WooProductCategory> firstRow = [];
  List<WooProductCategory> secoundRow = [];

  getCatories() {
    if (cat != null) {
      firstRow.clear();
      secoundRow.clear();
      for (var i = 0; i < cat.length; i++) {
        if (i < 4) {
          firstRow.add(cat[i]);
        } else {
          secoundRow.add(cat[i]);
        }
      }
      if (secoundRow.length > 4) {
        secoundRow.removeRange(4, secoundRow.length);
      }
      print(firstRow.length);
      print(secoundRow.length);
    }
  }
}
