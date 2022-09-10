import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:new_lampa/core/themes/colors.dart';
import 'package:new_lampa/core/utils/responsive.dart';
import 'package:new_lampa/presentation/componants/customtext.dart';

class ShippingPolicy extends StatelessWidget {
  const ShippingPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: CustomText(
        "Shipping & Returns Policy".tr(),
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
            // CustomText('Shipping & Returns', style: TextStyle(fontSize: 20)),
            // SizedBox(
            //   height: 20,
            // ),
            OrganizationData(
              header: "sh1".tr(),
              body: "sh2".tr(),
            ),
            OrganizationData(
              header: "sh3".tr(),
              body: "sh4".tr(),
            ),
            OrganizationData(
              header: "sh5".tr(),
              body: "sh6".tr(),
            ),
            OrganizationData(
              header: "sh7".tr(),
              body: "sh8".tr(),
            ),
          ],
        ),
      )),
    );
  }
}

class OrganizationData extends StatelessWidget {
  OrganizationData({required this.body, required this.header});
  String header, body;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          child: Row(
            children: [
              CustomText(
                header,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: CustomText('''$body''',
              color: Colors.grey.shade700, maxLines: 50),
        )
      ],
    );
  }
}
