import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart' as d;
import 'package:flutter_scroll_to_top/flutter_scroll_to_top.dart';
import 'package:new_lampa/core/themes/colors.dart';
import 'package:new_lampa/core/utils/responsive.dart';

import '../../componants/customtext.dart';
import '../../componants/loadinganderror.dart';
import '../../componants/product_widget.dart';
import '../../componants/shimer_loading_items.dart';
import '../../shared/adapterlist.dart';
import '../../shared/navigator.dart';
import '../cart/cubit/cubit.dart';
import '../favourite/cubit/cubit.dart';
import '../filter/filter_and_search_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    final cubit = HomePageCubit.get(context);
    final favcubit = FavouriteCubit.get(context);
    final cart = CartCubit.get(context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      cubit.getHomeData(context);
      // cubit.paginateHome(context);
      // cart.getDataCart(context: context);
      favcubit.getWishliste(context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageCubit, HomePageStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = HomePageCubit.get(context);
          return Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.startFloat,
            floatingActionButton: Padding(
              padding: EdgeInsets.symmetric(vertical: 66),
              child: FloatingActionButton(
                onPressed: () {
                  navigate(
                      context: context,
                      route: SearchScreen(
                        oldSearch: cubit.searchModel,
                        onchange: (s) {
                          cubit.searchModel = s;
                          print(s.searchtext);
                          Navigator.pop(context);
                          cubit.pagingController.refresh();
                        },
                      ));
                },
                child: Icon(Icons.search),
              ),
            ),
            body: ScrollWrapper(
                promptAlignment: Alignment.topCenter,
                promptDuration: const Duration(milliseconds: 400),
                promptTheme: PromptButtonTheme(
                    icon: Icon(Icons.arrow_circle_up, color: Colors.white),
                    color: AppColors.primiry,
                    iconPadding: EdgeInsets.all(16),
                    padding: EdgeInsets.all(85.h)),
                builder: (context, properties) {
                  return NotificationListener<ScrollEndNotification>(
                    onNotification: (s) {
                      if (s.metrics.maxScrollExtent == s.metrics.pixels) {
                        cubit.paginateHome(context);
                      }
                      return true;
                    },
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await cubit.getHomeData(context);
                      },
                      child: AdapterGridView(
                          // controller: cubit.shopController,
                          beforeList: [
                            Column(
                              children: <Widget>[
                                // BannersWidget(
                                //   banners: cubit.sliders,
                                //   centerText: false,
                                // ),
                                // CategoriesSection(),

                                //////////////////////////
                                // if (cubit.featuerd.isNotEmpty)
                                //   Padding(
                                //     padding: const EdgeInsets.only(
                                //         right: 15,
                                //         left: 15,
                                //         top: 20,
                                //         bottom: 15),
                                //     child: CustomText(
                                //       "featureprod".tr(),
                                //       color: AppColors.primiry,
                                //       weight: FontWeight.w700,
                                //       fontsize: 30.fs,
                                //       textStyleEnum: TextStyleEnum.title,
                                //     ),
                                //   ),
                                // if (cubit.featuerd.isNotEmpty)
                                //   SizedBox(
                                //       height: 200,
                                //       child: Row(
                                //         children: [
                                //           Expanded(
                                //             child: LoadingAndError(
                                //               isError: state
                                //                   is HomePageGetAdsErrorState,
                                //               isLoading: state
                                //                   is HomePageGetAdsLoadingState,
                                //               child: ListView.builder(
                                //                 //  physics: BouncingScrollPhysics(),
                                //                 //controller: FeaturedscrollController,
                                //                 scrollDirection:
                                //                     Axis.horizontal,
                                //                 itemBuilder: ((context,
                                //                         index) =>
                                //                     SizedBox(
                                //                       height: 200, width: 200.w,
                                //                       //  width: 150,
                                //                       //     height: 180,
                                //                       child: ProductWidget(
                                //                         products: cubit
                                //                             .featuerd[index],
                                //                         isTrend: false,
                                //                       ),
                                //                     )),
                                //                 itemCount:
                                //                     cubit.featuerd.length,
                                //               ),
                                //             ),
                                //           ),
                                //         ],
                                //       )),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 20),
                                  child: Row(
                                    children: <Widget>[
                                      CustomText(
                                        "shop".tr(),
                                        color: AppColors.primiry,
                                        weight: FontWeight.w700,
                                        fontsize: 30.fs,
                                        textStyleEnum: TextStyleEnum.title,
                                      ),
                                      // Spacer(),
                                      // PopupMenuButton(
                                      //     offset: (Offset(-30, 40)),
                                      //     itemBuilder: (context) => [
                                      //           PopupMenuItem(
                                      //               child: defaultText("showall".tr()))
                                      //         ])
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                          loadingWidget: ProductsLoadnigItem(),
                          afterList: [
                            SizedBox(
                              height: 70,
                            )
                          ],
                          loadingCondition: state is HomePageGetAdsLoadingState,
                          itemBuilder: (context, index) => ProductWidget(
                                products: cubit.shop[index],
                                isTrend: false,
                              ),
                          itemCount: cubit.shop.length),
                    ),
                  );
                }),
          );
        });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
