import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:new_lampa/core/utils/responsive.dart';

import '../../../../core/themes/colors.dart';
import '../../../../domain/models/product/wooproduct.dart';
import '../../../../domain/models/wishlist/woowishlist.dart';
import '../../../componants/customtext.dart';
import '../../../shared/network_image.dart';
import '../../product_screen/product_screen.dart';
import '../cubit/cubit.dart';

class CreateWhishListItem extends StatefulWidget {
  CreateWhishListItem({Key? key, required this.product}) : super(key: key);
  WooProduct product;

  @override
  _CreateWhishListItemState createState() => _CreateWhishListItemState();
}

class _CreateWhishListItemState extends State<CreateWhishListItem> {
//  int count = 1, price = 180;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductScreen(
                        product: widget.product,
                        // wooProduct:wooProduct ,
                      )));
        },
        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 5, right: 5, top: 16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                      margin:
                          EdgeInsets.only(right: 8, left: 8, top: 8, bottom: 8),
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(14)),
                        color: Colors.blue.shade200,
                        // image: DecorationImage(
                        //     image: Image.network(
                        //   widget.product.image!,
                        //   fit: BoxFit.fill,
                        // ).image)
                      ),
                      child: widget.product.images!.isNotEmpty
                          ? NetworkImagesWidgets(
                              widget.product.images!.first.src ?? "",
                              fit: BoxFit.fill,
                            )
                          : Image.asset(
                              "assets/images/placeholder.png",
                              fit: BoxFit.fill,
                            )),
                  Expanded(
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 160.w,
                              padding: EdgeInsets.only(right: 8, top: 4),
                              child: CustomText(
                                widget.product.name ?? "",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomText(
                                "${double.parse(widget.product.price ?? "0")} " +
                                    "sr".tr(),
                                fontsize: 16.fs,
                                color: AppColors.primiry,
                                weight: FontWeight.bold)
                          ],
                        ),
                      ],
                    ),
                    //  flex: 100,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      //      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          splashRadius: 10,
                          onPressed: () async {
                            FavouriteCubit.get(context).toggleWhislist(
                              context,
                              productId: widget.product.id ?? 0,
                            );
                          },
                          icon: Icon(
                            Icons.favorite,
                            color: AppColors.primiry,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            //
          ],
        ),
      ),
    );
  }
}
