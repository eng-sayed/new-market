import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../../core/themes/colors.dart';
import '../../componants/customtext.dart';
import '../cubit/layout_cubit.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar(this.cubit);
  final HomeLayoutCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.primiry,
      fixedColor: AppColors.white,
      currentIndex: cubit.tabController.index,
      //   iconSize: 20,
      elevation: 0,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "home".tr()),
        BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket), label: "shop".tr()),
        BottomNavigationBarItem(
            icon: Icon(Icons.category), label: "category".tr()),
        BottomNavigationBarItem(
            icon: Icon(Icons.view_module_rounded), label: "more".tr()),
      ],
      onTap: (i) {
        // cubit.tabController.animateTo(i);
        cubit.changeTab(i);
      },

      // child: SizedBox(
      //   child: Row(
      //     children: <Widget>[
      //       navBarItem(Ionicons.home_outline, 'home', ontap: () {
      //         cubit.changeTab("home");
      //       }),
      //       navBarItem(Ionicons.apps_outline, 'shop', ontap: () {
      //         cubit.changeTab("shop");
      //       }),
      //       navBarItem(Ionicons.heart_outline, 'category', ontap: () {
      //         cubit.changeTab("category");
      //       }),
      //       navBarItem(Ionicons.storefront_outline, 'more', ontap: () {
      //         cubit.changeTab("more");
      //       }),
      //     ],
      //   ),
      // ),
    );
  }

  Widget navBarItem(IconData icon, String title, {VoidCallback? ontap}) {
    return Expanded(
      child: InkWell(
        onTap: ontap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                icon,
                color: AppColors.white,
              ),
              SizedBox(
                height: 5,
              ),
              CustomText(title.tr(),
                  textStyleEnum: TextStyleEnum.normal, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
