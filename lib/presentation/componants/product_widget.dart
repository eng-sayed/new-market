import 'dart:math';

import 'package:animations/animations.dart';
import 'package:easy_localization/easy_localization.dart' as trans;
import 'package:flutter/material.dart';

import '../../core/themes/colors.dart';
import '../../domain/models/product/wooproduct.dart';
import '../screens/favourite_button/fav_button.dart';
import '../screens/product_screen/product_screen.dart';
import '../shared/animation_build_widget.dart';
import '../shared/navigator.dart';
import '../shared/network_image.dart';
import 'customtext.dart';

class ProductWidget extends StatefulWidget {
  // final int index;
  ProductWidget({Key? key, required this.products, this.isTrend = false})
      : super(key: key);
  final WooProduct products;
  final bool isTrend;

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  bool incart = false;
  int count = 1;
  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        navigate(
          context: context,
          route: ProductScreen(
            product: widget.products,
          ),
        );
      },
      child: Stack(
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(0),
                child: Card(
                  elevation: 2,
                  clipBehavior: Clip.hardEdge,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        // height: 3000,
                        child: Column(
                          mainAxisAlignment: widget.isTrend
                              ? MainAxisAlignment.center
                              : MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                                height: widget.isTrend ? 140 : 120,
                                width: double.infinity,
                                child: widget.products.images!.isEmpty
                                    ? Image.asset("assets/images/logo.png")
                                    : NetworkImagesWidgets(
                                        widget.products.images!.first.src!,
                                        fit: BoxFit.contain)),
                            // TODO
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: CustomText(widget.products.name!,
                                  fontsize: 13,
                                  align: TextAlign.center,
                                  maxLines: 1),
                            ),
                            if (widget.isTrend)
                              CustomText(
                                "Trending Now",
                                color: Colors.black,
                                fontsize: 13,
                              ),
                            // CustomText("Trending Now",
                            //     style: categoryStyle(color: AppColors.primiry)),
                            AnimationAppearanceOpacity(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  //TODO
                                  //
                                  ////  CustomText(mmm[widget.index].price!,
                                  //style: mainText(size: 15)),
                                  !widget.products.onSale!
                                      ? CustomText(
                                          "${double.tryParse(widget.products.regularPrice ?? '0')} ${"sr".tr()} ",
                                          fontsize: 15,
                                          color: AppColors.primiry,
                                        )
                                      : Row(
                                          children: [
                                            CustomText(
                                                "${double.tryParse(widget.products.regularPrice ?? '0')} ${"sr".tr()} ",
                                                fontsize: 13,
                                                color: AppColors.primiry,
                                                decoration:
                                                    TextDecoration.lineThrough),
                                            SizedBox(
                                              width: 3,
                                            ),
                                            CustomText(
                                                "${double.tryParse(widget.products.salePrice ?? '0')} ${"sr".tr()} ",
                                                fontsize: 16,
                                                color: AppColors.primiry,
                                                weight: FontWeight.bold),
                                            //Spacer(),
                                          ],
                                        ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (widget.products.onSale!)
                        Banner(
                          message:
                              "${((double.tryParse(widget.products.regularPrice ?? '0') ?? 0 - (double.tryParse(widget.products.salePrice ?? '0') ?? 0)) / (double.tryParse(widget.products.regularPrice ?? '0') ?? 0) * 100).toStringAsFixed(1)} %",
                          location: BannerLocation.topEnd,
                          color: Colors.red,
                        )
                    ],
                  ),
                ),
              ),
              widget.products.stockStatus == 'outofstock'
                  ? Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding:
                            EdgeInsets.only(bottom: widget.isTrend ? 40 : 20),
                        child: Container(
                          child: Image.asset(
                            'assets/images/sold.png',
                            width: 150,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.transparent.withOpacity(.0),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    )
                  : Container()
            ],
          ),
          Positioned.directional(
              textDirection: context.locale == Locale('en', 'US')
                  ? TextDirection.ltr
                  : TextDirection.rtl,
              top: 20,
              start: 20,
              child:
                  // FavouritButton(
                  //   product: widget.products,
                  // )

                  //   Consumer<WishlListController>(builder: (context, value, child) {
                  // return
                  FavouriteButton(
                product: widget.products,
              )
              //   }),
              ),
        ],
      ),
    );
    // return GestureDetector(
    //   onTap: () {
    //     navigate(
    //       context: context,
    //       route: ProductScreen(
    //         productId: widget.products.id,
    //       ),
    //     );
    //   },
    //   child: Stack(
    //     children: [
    //       Stack(
    //         children: [
    //           Padding(
    //             padding: const EdgeInsets.all(0),
    //             child: Card(
    //               elevation: 2,
    //               clipBehavior: Clip.hardEdge,
    //               shape: RoundedRectangleBorder(
    //                 borderRadius: BorderRadius.circular(15),
    //               ),
    //               child: Stack(
    //                 alignment: AlignmentDirectional.topEnd,
    //                 children: [
    //                   Container(
    //                     // height: 3000,
    //                     color: AppColors.primiry,
    //                     child: Column(
    //                       mainAxisAlignment: widget.isTrend
    //                           ? MainAxisAlignment.center
    //                           : MainAxisAlignment.start,
    //                       children: <Widget>[
    //                         SizedBox(
    //                             height: widget.isTrend ? 140 : 120,
    //                             width: double.infinity,
    //                             child: widget.products.images!.isEmpty
    //                                 ? Image.asset(
    //                                     "assets/images/logo.png",
    //                                     fit: BoxFit.fill,
    //                                   )
    //                                 : NetworkImagesWidgets(
    //                                     widget.products.images!.first.src!,
    //                                     fit: BoxFit.contain)),
    //                         // TODO
    //                         Padding(
    //                           padding: EdgeInsets.symmetric(horizontal: 5),
    //                           child: CustomText(
    //                             widget.products.name!,
    //                             maxLines: 1,
    //                             color: AppColors.white,
    //                             weight: FontWeight.w500,
    //                             align: TextAlign.center,
    //                           ),
    //                         ),
    //                         if (widget.isTrend)
    //                           CustomText(
    //                             "Trending Now",
    //                             color: AppColors.black,
    //                             fontsize: 13,
    //                           ),
    //                         AnimationAppearanceOpacity(
    //                           child: Row(
    //                             mainAxisAlignment: MainAxisAlignment.center,
    //                             children: <Widget>[
    //                               //TODO
    //                               //
    //                               ////  CustomText(mmm[widget.index].price!,
    //                               //style: mainText(size: 15)),
    //                               !widget.products.onSale!
    //                                   ? CustomText(
    //                                       "${double.tryParse(widget.products.price ?? "0")} ${"sr".tr()} ",
    //                                       fontsize: 15,
    //                                       weight: FontWeight.w700,
    //                                       color: AppColors.white,
    //                                     )
    //                                   : Row(
    //                                       children: [
    //                                         CustomText(
    //                                             "${double.tryParse(widget.products.regularPrice ?? "0")} ${"sr".tr()} ",
    //                                             fontsize: 13,
    //                                             weight: FontWeight.w700,
    //                                             color: AppColors.white,
    //                                             decoration:
    //                                                 TextDecoration.lineThrough),
    //                                         SizedBox(
    //                                           width: 3,
    //                                         ),
    //                                         CustomText(
    //                                           "${double.tryParse(widget.products.salePrice ?? "0")} ${"sr".tr()} ",
    //                                           fontsize: 16,
    //                                           color: AppColors.white,
    //                                           weight: FontWeight.w700,
    //                                         ),
    //                                         //Spacer(),
    //                                       ],
    //                                     ),
    //                             ],
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                   if (widget.products.onSale!)
    //                     Banner(
    //                       message:
    //                           "${((double.parse(widget.products.regularPrice ?? "0") - double.parse(widget.products.salePrice ?? "0")) / double.parse(widget.products.regularPrice ?? "0") * 100).toStringAsFixed(1)} %",
    //                       location: BannerLocation.topEnd,
    //                       color: Colors.red,
    //                     )
    //                 ],
    //               ),
    //             ),
    //           ),
    //           widget.products.stockStatus == 'outofstock'
    //               ? Align(
    //                   alignment: Alignment.center,
    //                   child: Padding(
    //                     padding:
    //                         EdgeInsets.only(bottom: widget.isTrend ? 40 : 20),
    //                     child: Container(
    //                       child: Image.asset(
    //                         'assets/images/sold.png',
    //                         width: 150,
    //                       ),
    //                       decoration: BoxDecoration(
    //                         color: Colors.transparent.withOpacity(.0),
    //                         borderRadius: BorderRadius.circular(15),
    //                       ),
    //                     ),
    //                   ),
    //                 )
    //               : Container(),
    //           FavouriteButton(
    //             product: widget.products,
    //           ),
    //         ],
    //       ),
    //     ],
    //   ),
    // );
  }
}

//mixin WishlListController {}
