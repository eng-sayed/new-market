import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:new_lampa/core/themes/colors.dart';
import 'package:new_lampa/core/utils/responsive.dart';

import '../../domain/models/order/wooorder.dart';
import '../componants/customtext.dart';

class ProductOrderWidget extends StatelessWidget {
  const ProductOrderWidget({Key? key, required this.items}) : super(key: key);
  final LineItems items;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
            // leading: Container(
            //   clipBehavior: Clip.hardEdge,
            //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            //   width: 100.w,
            //   height: 100.h,
            //   child: NetworkImagesWidgets(
            //     url: fruitsdemo.first,
            //   ),
            // ),
            title: CustomText(items.name!,
                fontsize: 15.fs,
                color: AppColors.primiry,
                weight: FontWeight.bold),
            subtitle: Row(
              children: [
                SizedBox(width: 3.w),
                CustomText("${items.price} ${"sr".tr()}",
                    fontsize: 16.fs,
                    color: AppColors.primiry,
                    weight: FontWeight.bold),
              ],
            ),
            trailing: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CustomText("${items.subtotal} ${"sr".tr()}",
                    color: AppColors.primiry,
                    weight: FontWeight.bold,
                    fontsize: 17.fs),
                CustomText("x ${items.quantity} ",
                    color: Colors.grey, fontsize: 15.fs)
              ],
            )),
        Divider(
          color: Colors.grey,
        )
      ],
    );
  }
}
