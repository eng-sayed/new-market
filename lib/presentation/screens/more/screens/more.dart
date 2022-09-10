import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:new_lampa/core/themes/colors.dart';
import 'package:new_lampa/core/utils/responsive.dart';
import 'package:new_lampa/presentation/componants/customtext.dart';
import 'package:new_lampa/presentation/screens/more/screens/about_us.dart';
import 'package:new_lampa/presentation/screens/more/screens/shipping_policy.dart';
import 'package:new_lampa/presentation/screens/more/screens/terms_conditions.dart';
import 'package:new_lampa/presentation/screens/profile/profile.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/utils/app_info.dart';
import '../../../../core/utils/utils.dart';
import '../../../layout/layout.dart';
import '../../../shared/navigator.dart';
import '../../cart/widgets/requirdLogin.dart';
import '../../favourite/favourite.dart';
import '../../orders/orders.dart';
import '../../profile/widgets/delete_user_dialog.dart';
import '../../shop/shop.dart';
import '../weidgets/drawer_item.dart';
import '../weidgets/squre_button.dart';
import 'contact.dart';

class AccountScreen extends StatefulWidget {
  AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 100.0.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SqureButton(
                onTap: () => navigate(context: context, route: OrdersScreen()),
                icon: Icons.shopping_bag,
                text: "Orders".tr(),
              ),
              SqureButton(
                icon: Icons.favorite,
                text: "WhishList".tr(),
                onTap: () => navigate(context: context, route: Favourite()),
              ),
              SqureButton(
                icon: Icons.person,
                text: "profile".tr(),
                onTap: () async {
                  Utiles.token.isNotEmpty
                      ? navigate(context: context, route: ProfileScreen())
                      : showDialog(
                          context: context,
                          builder: (BuildContext context) => RequirdLogin());
                },
              ),
            ],
          ),
          SizedBox(
            child: Divider(),
          ),
          DrawerItem(
              text: "first drawer".tr(),
              icon: Icons.money_off_csred_sharp,
              route: ShopScreen(
                onsale: true,
                title: "first drawer",
              )),
          DrawerItem(
            text: "newarrival".tr(),
            icon: Icons.fiber_new_rounded,
            route: ShopScreen(
              title: "newarrival".tr(),
            ),
          ),
          DrawerItem(
            text: "About US".tr(),
            icon: Icons.info,
            route: AboutUs(),
          ),
          DrawerItem(
            text: "Contact Us".tr(),
            icon: Icons.mail,
            route: Contact(),
          ),
          DrawerItem(
            text: "Shipping & Returns Policy".tr(),
            icon: Icons.delivery_dining,
            route: ShippingPolicy(),
          ),
          DrawerItem(
            text: "Terms & Conditions".tr(),
            icon: Icons.contact_support_sharp,
            route: TermsAndConditions(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.app_registration,
                                    color: AppColors.primiry,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  CustomText("App Version".tr(),
                                      color: Colors.black),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: CustomText(AppInfo().version ?? '00',
                                        color: Colors.black),
                                  ),
                                ],
                              ),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomText(
                                  'Powerd by '.tr(),
                                  color: Colors.black54,
                                  fontsize: 12,
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await launch("https://www.reeras.net");
                                },
                                child: Opacity(
                                  opacity: 1,
                                  child: Image.asset(
                                    "assets/images/reeraslogoblack.png",
                                    width: 120,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              // CustomText(
                              //   'REERAS Technologies'.tr(),
                              //   style: mainText(
                              //       color: Colors.black87, size: 12),
                              // ),
                            ],
                          ),
                        ),
                      );
                    });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.app_registration,
                        color: AppColors.primiry,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      CustomText("App info".tr(), color: Colors.black)
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (Utiles.token.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: InkWell(
                onTap: () async {
                  await Utiles.logout();
                  navigateReplacement(context: context, route: HomeLayout());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.logout,
                          color: AppColors.primiry,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        CustomText("fifth drawer".tr(), color: Colors.black)
                      ],
                    ),
                  ],
                ),
              ),
            ),
          if (Utiles.token.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: InkWell(
                onTap: () async {
                  showDialog(
                      context: context,
                      builder: (context) => DeleteUserDialog());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        CustomText("deleteAccount".tr(), color: Colors.red)
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    ));
  }
}
