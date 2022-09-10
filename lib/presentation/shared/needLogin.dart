import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:new_lampa/core/utils/responsive.dart';

import '../../core/themes/colors.dart';
import '../../core/utils/utils.dart';
import '../componants/customtext.dart';
import '../screens/auth/screens/auth_screen.dart';
import 'navigator.dart';

class NeedLogin extends StatelessWidget {
  const NeedLogin({
    Key? key,
    required this.child,
    this.showAppBar = true,
  }) : super(key: key);
  final Widget child;
  final bool showAppBar;
  @override
  Widget build(BuildContext context) {
    return Utiles.token.isNotEmpty
        ? child
        : Scaffold(
            appBar: showAppBar ? AppBar() : null,
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LottieBuilder.asset(
                      "assets/json/login.json",
                      height: 150,
                      width: 150,
                    ),
                    CustomText(
                      "mustlogin".tr(),
                      color: AppColors.primiry,
                      fontsize: 24.fs,
                      weight: FontWeight.bold,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          navigate(context: context, route: AuthScreen());
                        },
                        style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                        child: CustomText(
                          "login".tr(),
                          color: AppColors.white,
                        )),
                  ],
                ),
              ),
            ));
  }
}
