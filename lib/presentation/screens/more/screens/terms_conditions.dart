import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:new_lampa/core/themes/colors.dart';
import 'package:new_lampa/core/utils/responsive.dart';
import 'package:new_lampa/presentation/screens/more/screens/shipping_policy.dart';

import '../../../componants/customtext.dart';

class TermsAndConditions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: CustomText(
        "Terms & Conditions".tr(),
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
            // CustomText('Terms & Conditions', style: TextStyle(fontSize: 20)),
            // SizedBox(
            //   height: 20,
            // ),
            OrganizationData(
              header: "Terms & Conditions".tr(),
              body: 'term1'.tr(),
            ),
            OrganizationData(
              header: 'term2'.tr(),
              body: 'term3'.tr(),
            ),
            OrganizationData(
              header: 'term4'.tr(),
              body: 'term5'.tr(),
            ),
            OrganizationData(
              header: "term6".tr(),
              body: '''term7'''.tr(),
            ),
          ],
        ),
      )),
    );
    ;
  }
}
