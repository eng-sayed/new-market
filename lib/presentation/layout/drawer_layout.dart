// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:ionicons/ionicons.dart';
// import 'package:threefood/core/themes/colors.dart';
// import 'package:threefood/core/utils/responsive.dart';
// import 'package:threefood/core/utils/utils.dart';
// import 'package:threefood/presentation/componants/customtext.dart';
// import 'package:threefood/presentation/layout/layout.dart';
// import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
// import 'package:threefood/presentation/screens/auth/screens/auth_screen.dart';
// import 'package:threefood/presentation/screens/profile/profile.dart';
// import 'package:threefood/presentation/screens/shop/shop.dart';

// import '../screens/orders/orders.dart';
// import '../shared/background.dart';
// import '../shared/navigator.dart';

// ZoomDrawerController zoomDrawerController = ZoomDrawerController();

// class DrawerScreen extends StatefulWidget {
//   DrawerScreen({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<DrawerScreen> createState() => _DrawerScreenState();
// }

// class _DrawerScreenState extends State<DrawerScreen> {
//   bool isLogin = Utiles.token.isNotEmpty;
//   bool drawerClose = true;
//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
//       setState(() {});
//       zoomDrawerController.stateNotifier!.addListener(() {
//         drawerClose =
//             zoomDrawerController.stateNotifier!.value == DrawerState.closed;
//         setState(() {});
//       });
//     });

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ZoomDrawer(
//       isRtl: context.locale == Locale('en', 'US') ? false : true,
//       swipeOffset: 0,
//       style: DrawerStyle.DefaultStyle,
//       controller: zoomDrawerController,
//       shadowLayer1Color: Colors.black,
//       boxShadow: [
//         BoxShadow(color: Colors.black12, offset: Offset(-10, 10)),
//         BoxShadow(color: Colors.black12, offset: Offset(-20, 20))
//       ],
//       menuScreen: Material(
//         child: AnimatedBackgroundWidget(
//           child: Ink(
//             decoration: BoxDecoration(
//                 /*  gradient: LinearGradient(
//                   colors: [
//               greenColor,
//               Colors.green,
//             ],
//              begin: Alignment.bottomCenter, end: Alignment.topCenter) */
//                 ),
//             //color: Color(0xFF8EC045),
//             child: Padding(
//               padding: const EdgeInsets.all(15.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Spacer(),
//                   SizedBox(
//                     width: 140.w,
//                     child: Image.asset(
//                       "assets/images/logo.png",
//                     ),
//                   ),
//                   Spacer(),
//                   Utiles.token.isEmpty
//                       ? Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: <Widget>[
//                             CustomText("welcome".tr(),
//                                 color: AppColors.primiry,
//                                 fontsize: 20.fs,
//                                 weight: FontWeight.bold),
//                             SizedBox(
//                               height: 5,
//                             ),
//                             CustomText(
//                               "gustmsg".tr(),
//                               color: AppColors.primiry,
//                               fontsize: 13.fs,
//                             ),
//                             SizedBox(
//                               height: 5,
//                             ),
//                             Row(
//                               children: [
//                                 ElevatedButton(
//                                     style: ElevatedButton.styleFrom(
//                                         shape: StadiumBorder(),
//                                         primary: AppColors.primiry),
//                                     onPressed: () {
//                                       navigate(
//                                           context: context,
//                                           route: AuthScreen(
//                                             isregister: false,
//                                           ));
//                                     },
//                                     child: CustomText("login".tr(),
//                                         color: AppColors.white)),
//                                 SizedBox(
//                                   width: 5,
//                                 ),
//                                 ElevatedButton(
//                                     style: ElevatedButton.styleFrom(
//                                         shape: StadiumBorder(),
//                                         primary: AppColors.secondary),
//                                     onPressed: () {
//                                       navigate(
//                                           context: context,
//                                           route: AuthScreen(
//                                             isregister: true,
//                                           ));
//                                     },
//                                     child: CustomText("register".tr(),
//                                         color: AppColors.white))
//                               ],
//                             ),
//                           ],
//                         )
//                       : CustomText("${"welcome".tr()} ${Utiles.Username}",
//                           color: AppColors.primiry,
//                           fontsize: 20.fs,
//                           weight: FontWeight.bold),
//                   Divider(),
//                   if (Utiles.token.isNotEmpty)
//                     InkWell(
//                       onTap: () {
//                         navigate(context: context, route: ProfileScreen());
//                       },
//                       child: DrawerItem(
//                         title: "profile".tr(),
//                         icon: Ionicons.person_outline,
//                       ),
//                     ),
//                   InkWell(
//                     onTap: () {
//                       navigate(
//                           context: context,
//                           route: ShopScreen(
//                             title: "first drawer".tr(),
//                             onsale: true,
//                           ));
//                     },
//                     child: DrawerItem(
//                       title: "first drawer".tr(),
//                       icon: Icons.local_offer_outlined,
//                     ),
//                   ),
//                   InkWell(
//                     onTap: () {
//                       navigate(context: context, route: OrdersScreen());
//                     },
//                     child: DrawerItem(
//                       title: "sec drawer".tr(),
//                       icon: Icons.shopping_bag_outlined,
//                     ),
//                   ),
//                   InkWell(
//                     onTap: () {
//                       //      navigate(context: context, route: FavouriteScreen());
//                     },
//                     child: DrawerItem(
//                       title: "About US".tr(),
//                       icon: Ionicons.person_outline,
//                     ),
//                   ),
//                   InkWell(
//                     onTap: () {
//                       //      navigate(context: context, route: FavouriteScreen());
//                     },
//                     child: DrawerItem(
//                       title: "Contact Us".tr(),
//                       icon: Ionicons.call_outline,
//                     ),
//                   ),
//                   InkWell(
//                     onTap: () async {
//                       context.locale == Locale('en', 'US')
//                           ? context.setLocale(Locale('ar', 'EG'))
//                           : context.setLocale(Locale('en', 'US'));
//                       // navigateReplacement(
//                       //     context: context, route: DrawerScreen());
//                     },
//                     child: DrawerItem(
//                       title: context.locale == Locale('en', 'US')
//                           ? "العربيه"
//                           : "English",
//                       icon: Icons.language,
//                     ),
//                   ),

//                   // DrawerItem(
//                   //   title: "Settings",
//                   //   icon: Icons.settings_outlined,
//                   // ),
//                   /*  DrawerItem(
//                     title: "Languages",
//                     icon: Icons.language,
//                   ), */
//                   Spacer(),
//                   if (Utiles.token.isNotEmpty)
//                     InkWell(
//                       onTap: () async {
//                         Utiles.logout();
//                         navigateReplacement(
//                             context: context, route: DrawerScreen());
//                       },
//                       child: DrawerItem(
//                         title: "forth drawer".tr(),
//                         icon: Icons.logout_outlined,
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//       mainScreen: Stack(
//         children: [
//           HomeLayout(),
//           if (!drawerClose)
//             Material(
//               color: Colors.transparent,
//               child: InkWell(
//                   onTap: () {
//                     zoomDrawerController.close!.call();
//                     drawerClose = false;

//                     setState(() {});
//                   },
//                   child: SizedBox.expand()),
//             )
//         ],
//       ),
//       borderRadius: 24.0,
//       mainScreenTapClose: true,
//       showShadow: true,
//       angle: -1.0,
//       backgroundColor: Colors.grey,
//       slideWidth: 200,
//     );
//   }
// }

// class DrawerItem extends StatelessWidget {
//   String title;
//   IconData? icon;
//   DrawerItem({Key? key, required this.title, this.icon}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10),
//       child: Row(
//         children: [
//           Icon(
//             icon ?? Icons.clear,
//             color: AppColors.primiry,
//           ),
//           SizedBox(
//             width: 10,
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 5),
//             child: CustomText("$title",
//                 color: AppColors.primiry, weight: FontWeight.w600),
//           ),
//         ],
//       ),
//     );
//   }
// }
