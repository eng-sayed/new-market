import 'package:easy_localization/easy_localization.dart';
import 'package:lottie/lottie.dart';

import 'package:flutter/material.dart';
import 'package:new_lampa/core/utils/responsive.dart';

import '../../core/themes/colors.dart';
import 'customtext.dart';
import 'myLoading.dart';

class LoadingAndError extends StatelessWidget {
  const LoadingAndError(
      {Key? key,
      this.childError,
      this.childLoading,
      required this.isError,
      required this.isLoading,
      required this.child})
      : super(key: key);
  final bool isError;
  final bool isLoading;
  final Widget child;
  final Widget? childError;
  final Widget? childLoading;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      if (isError) {
        return childError ??
            Material(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Lottie.asset(
                      "assets/json/error.json",
                      width: 150,
                      height: 150,
                    ),
                    CustomText(
                      'error'.tr(),
                      fontsize: 18.fs,
                      color: AppColors.primiry,
                    ),
                    if (Navigator.canPop(context))
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: CustomText(
                            "back".tr(),
                            color: AppColors.white,
                          ))
                  ],
                ),
              ),
            );
      } else if (isLoading) {
        return childLoading ?? Material(child: MyLoading.loadingWidget());
      } else {
        return child;
      }
    });
  }
}
