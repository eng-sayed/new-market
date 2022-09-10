import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_lampa/core/utils/responsive.dart';
import 'package:new_lampa/presentation/componants/customtext.dart';
import 'package:new_lampa/presentation/screens/cart/cubit/states.dart';
import 'package:new_lampa/presentation/shared/navigator.dart';

import 'package:provider/provider.dart';

import '../../core/themes/colors.dart';
import '../screens/cart/cubit/cubit.dart';
import '../screens/home/home.dart';
import 'opacity_loading.dart';

class UploadCart extends StatelessWidget {
  const UploadCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: BlocConsumer<CartCubit, CartStates>(
          listener: (context, state) {},
          builder: (context, state) {
            final cubit = CartCubit.get(context);

            return OpacityLoadingWidget(
              loadingCondition: state is UploadCartGetLoading,
              child: Dialog(
                clipBehavior: Clip.hardEdge,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      CustomText("uploadcart".tr(),
                          weight: FontWeight.bold,
                          color: AppColors.primiry,
                          fontsize: 15.fs),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          InkWell(
                            onTap: () async {
                              await cubit.uploadCartItems(context);
                              navigateReplacement(
                                  context: context, route: HomePage());
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomText(
                                "yes".tr(),
                                weight: FontWeight.bold,
                                color: AppColors.primiry,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              navigateReplacement(
                                  context: context, route: HomePage());
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomText(
                                "no".tr(),
                                weight: FontWeight.bold,
                                color: AppColors.primiry,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
