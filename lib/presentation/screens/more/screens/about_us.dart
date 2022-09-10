import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:new_lampa/core/themes/colors.dart';
import 'package:new_lampa/core/utils/responsive.dart';

import '../../../componants/customtext.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: CustomText(
        "About US".tr(),
        color: AppColors.white,
        fontsize: 19,
      )),
      body: SingleChildScrollView(
          child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10.h,
            ),
            CircleAvatar(
              backgroundColor: AppColors.white,
              backgroundImage: Image.asset("assets/images/logo.png").image,
              radius: 80.fs,
            ),
            SizedBox(
              height: 20,
            ),
            CustomText(
              "About US".tr(),
              color: Colors.grey.shade700,
              fontsize: 16.fs,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomText('''aboutusData'''.tr(),
                  color: Colors.grey.shade700, maxLines: 50),
            )
          ],
        ),
      )),
    );
  }
}
