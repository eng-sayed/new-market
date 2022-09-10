import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:new_lampa/core/themes/colors.dart';
import 'package:new_lampa/core/utils/responsive.dart';
import 'package:new_lampa/presentation/componants/customtext.dart';

import '../../../domain/models/order/wooorder.dart';

class OrderTrackingWidget extends StatelessWidget {
  OrderTrackingWidget({Key? key, required this.order}) : super(key: key);
  WooOrder order;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        (order.status == "processing" ||
                order.status == "completed" ||
                order.status == "on-hold")
            ? Stepper(
                steps: [
                  Step(
                      title: CustomText("onhold".tr(),
                          color: AppColors.primiry, fontsize: 18.fs),
                      subtitle: CustomText(
                          "${DateFormat('dd-MM-yyyy hh:mm a').format(DateTime.parse(order.dateCreated!))}",
                          color: Colors.grey,
                          fontsize: 12.fs),
                      content: SizedBox(
                        width: double.infinity,
                      ),
                      isActive: true),
                  Step(
                      title: CustomText("processing".tr(),
                          color: AppColors.primiry, fontsize: 18.fs),
                      subtitle:
                          CustomText("", color: Colors.grey, fontsize: 12.fs),
                      content: SizedBox(
                        width: double.infinity,
                      ),
                      isActive: (order.status == "processing" ||
                          order.status == "completed")),
                  Step(
                      title: CustomText("completed".tr(),
                          color: AppColors.primiry, fontsize: 18.fs),
                      subtitle: CustomText(
                          "${order.dateCompleted != null ? DateFormat('dd-MM-yyyy hh:mm a').format(DateTime.parse(order.dateCompleted!)) : ""}",
                          color: Colors.grey,
                          fontsize: 12.fs),
                      content: SizedBox(
                        width: double.infinity,
                      ),
                      isActive: order.status == "completed"),
                ],
                controlsBuilder: (context, details) {
                  return SizedBox();
                },
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomText("canceled".tr(),
                      color: AppColors.primiry, fontsize: 18.fs),
                  CustomText(
                      order.dateCompleted != null
                          ? DateFormat('dd-MM-yyyy hh:mm a')
                              .format(DateTime.parse(order.dateCompleted!))
                          : "",
                      color: AppColors.primiry,
                      fontsize: 18.fs),
                ],
              ),
      ],
    );
  }
}
