import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

import 'package:flutter/material.dart';
import 'package:new_lampa/core/utils/utils.dart';
import 'package:new_lampa/presentation/componants/customtext.dart';

import '../../core/themes/colors.dart';
import '../componants/animated_header.dart';
import '../screens/categories/categories.dart';
import '../screens/favourite/favourite.dart';
import '../screens/home/home.dart';
import '../screens/more/screens/more.dart';
import '../screens/shop/shop.dart';
import 'cubit/layout_cubit.dart';
import 'cubit/layout_states.dart';
import 'floatbutton.dart';
import 'widgets/bottom_navbar.dart';
import 'widgets/exit_dialog.dart';

class HomeLayout extends StatefulWidget {
  HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    final cubit = HomeLayoutCubit.get(context);
    cubit.tabController =
        TabController(length: 4, vsync: this, initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = HomeLayoutCubit.get(context);
    return BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return WillPopScope(
            onWillPop: () async {
              return await showDialog(
                  context: context, builder: (context) => ExitDialog());
            },
            child: Scaffold(
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.miniEndFloat,
              floatingActionButton: Padding(
                padding: const EdgeInsets.only(bottom: 70),
                child: FloatingActionButton(
                  heroTag: null,
                  child: Icon(Icons.whatsapp),
                  onPressed: () {
                    Utiles().openwhatsapp(context);
                  },
                ),
              ),
              body: Container(
                color: AppColors.primiry,
                child: SafeArea(
                  top: false,
                  child: Scaffold(
                    floatingActionButtonLocation:
                        FloatingActionButtonLocation.centerDocked,
                    floatingActionButton: MyFloatActionButton(),
                    extendBody: true,
                    // appBar:
                    //     // cubit.tabController.index == 3
                    //     //     ? null
                    //     //     :
                    //     AppBar(
                    //   title: Image(
                    //     color: AppColors.white,
                    //     image: AssetImage(
                    //       "assets/images/logo.png",
                    //     ),
                    //     height: 50,
                    //   ),
                    //   centerTitle: true,
                    //   // leading: IconButton(
                    //   //   icon: Icon(Ionicons.menu),
                    //   //   onPressed: () {
                    //   //     zoomDrawerController.toggle?.call();
                    //   //   },
                    //   // ),
                    // ),
                    body: TabBarView(
                      controller: cubit.tabController,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        Header(child: HomePage()),
                        const ShopScreen(
                          title: "shop",
                          showBack: false,
                        ),
                        const Categories(),
                        Header(child: AccountScreen()),
                      ],
                    ),
                    bottomNavigationBar: CustomBottomNavBar(cubit),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
