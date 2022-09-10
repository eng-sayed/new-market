import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/themes/colors.dart';
import '../../domain/models/product/wooproduct.dart';
import '../screens/favourite_button/fav_button.dart';
import '../screens/product_screen/product_screen.dart';
import '../shared/navigator.dart';
import '../shared/network_image.dart';
import 'customtext.dart';

class ProductListItem extends StatefulWidget {
  ProductListItem({Key? key, required this.product}) : super(key: key);
  WooProduct product;

  @override
  _ProductListItemState createState() => _ProductListItemState();
}

class _ProductListItemState extends State<ProductListItem> {
//  int count = 1, price = 180;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigate(
            context: context,
            route: ProductScreen(
              product: widget.product,
            ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Card(
          elevation: 5,
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Stack(
            alignment: AlignmentDirectional.topStart,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GestureDetector(
                  onTap: () {
                    navigate(
                        context: context,
                        route: ProductScreen(
                          product: widget.product,
                        ));
                  },
                  child: Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 5, right: 5, top: 0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(16))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(
                                  right: 8, left: 8, top: 8, bottom: 8),
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(14)),
                                // color: Colors.blue.shade200,
                                // image: DecorationImage(
                                //     image: Image.network(
                                //   widget.product.images![0].src!,
                                //   fit: BoxFit.contain,
                                // ).image)
                              ),
                              child: widget.product.images!.isEmpty
                                  ? Image.asset("assets/images/placeholder.png")
                                  : Image.network(
                                      widget.product.images![0].src!,
                                      fit: BoxFit.fill,
                                    ),
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            //width: 120.w,
                                            padding: EdgeInsets.only(
                                                right: 8, top: 4),
                                            child: CustomText(
                                              widget.product.name!,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          !widget.product.onSale!
                                              ? CustomText(
                                                  "${double.tryParse(widget.product.price ?? "0")} ${"sr".tr()} ",
                                                  fontsize: 15,
                                                  weight: FontWeight.w700,
                                                  color: AppColors.primiry)
                                              : Row(
                                                  children: [
                                                    CustomText(
                                                        "${double.tryParse(widget.product.regularPrice ?? "0")} ${"sr".tr()} ",
                                                        fontsize: 13,
                                                        weight: FontWeight.w700,
                                                        color:
                                                            AppColors.primiry,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough),
                                                    SizedBox(
                                                      width: 3,
                                                    ),
                                                    CustomText(
                                                      "${double.tryParse(widget.product.salePrice ?? "0")} ${"sr".tr()} ",
                                                      fontsize: 16,
                                                      color: AppColors.primiry,
                                                      weight: FontWeight.w700,
                                                    ),
                                                    //Spacer(),
                                                  ],
                                                ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //  flex: 100,
                            ),
                            FavouriteButton(product: widget.product)
                          ],
                        ),
                      ),
                      //
                    ],
                  ),
                ),
              ),
              if (widget.product.onSale!)
                Banner(
                  color: Colors.red,
                  message:
                      '${((double.parse(widget.product.regularPrice!) - double.parse(widget.product.salePrice!)) / double.parse(widget.product.regularPrice!) * 100).toStringAsFixed(0)} %',
                  location: BannerLocation.topStart,
                )
            ],
          ),
        ),
      ),
    );
  }
}
