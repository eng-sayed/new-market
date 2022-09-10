import 'package:flutter/material.dart';
import 'package:new_lampa/core/themes/colors.dart';
import 'dart:math';

import 'package:animations/animations.dart';
import 'package:easy_localization/easy_localization.dart' as trans;
import 'package:new_lampa/core/utils/responsive.dart';
import 'package:new_lampa/presentation/componants/customtext.dart';

import '../shared/background.dart';

TrackingScrollController? scontroller2 = TrackingScrollController();

class Header extends StatefulWidget {
  Header({
    Key? key,
    required this.child,
  }) : super(key: key);
  Widget child;

  @override
  State<Header> createState() => _HeaderState();
}

double avatarSize = 150;
const avatarColor = Colors.orange;
double minAvatarSize = 38;
const extraSpace = 0;

class _HeaderState extends State<Header> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: AppColors.lightGreybackgound,
        child: NestedScrollView(
            //  controller: scontroller2,
            //   physics: NeverScrollableScrollPhysics(),
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverPersistentHeader(
                  delegate: MyHeaderDelegate(
                    kToolbarHeight + avatarSize + extraSpace,
                  ),
                  pinned: true,
                ),
              ];
            },
            body: widget.child));
  }
}

class MyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double extendedHeight;
  MyHeaderDelegate(
    this.extendedHeight,
  );

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    //  print("shrinkOffset: $shrinkOffset ... $overlapsContent");
    double newSize = maxExtent - shrinkOffset;
    double newSizePercent = avatarSize + extraSpace - shrinkOffset;
    double newAvatarSize = avatarSize - shrinkOffset;
    double newAvatarSpace = avatarSize - shrinkOffset;

    if (newSize < minExtent) {
      newSize = minExtent;
    }
    if (newAvatarSize < minAvatarSize) {
      newAvatarSize = minAvatarSize;
    }
    if (newAvatarSpace < 0) {
      newAvatarSpace = 0;
    }
    final percent = (newSizePercent >= 0 ? newSizePercent : 0) /
        (avatarSize + extraSpace).abs();
    double avatarXPosition = max(
        ((MediaQuery.of(context).size.width / 2) - newAvatarSize / 2) * percent,
        15);

    double actionsXPosition = 50 * (1 - percent);
    //  final colorTween = Tween<Color>(begin: Colors.white, end: mainColor);
    return Container(
      color: shrinkOffset == 0
          ? AppColors.lightGreybackgound
          : AppColors.primiry.withOpacity(1 - percent),
      child: AnimatedBackgroundWidget(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Container(
                height: kToolbarHeight + newAvatarSpace,
                child: Stack(
                  children: [
                    AppBar(
                      leadingWidth: 100.w,
                      titleSpacing: 0,
                      leading: Opacity(
                        opacity: 1 - percent,
                        child: TextButton(
                          onPressed: () {
                            context.locale == Locale('en', 'US')
                                ? context.setLocale(Locale('ar', 'EG'))
                                : context.setLocale(Locale('en', 'US'));
                          },
                          child: Text(
                            context.locale == Locale('en', 'US')
                                ? 'عربي'
                                : 'English',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      // leading: IconButton(
                      //   onPressed: () {
                      //     zoomDrawerController.toggleDrawer();
                      //   },
                      //   icon: Icon(Icons.menu),
                      // ),
                      iconTheme: IconThemeData(
                          color: Colors.white.withOpacity(1 - percent)),
                      title: Opacity(
                          opacity: 1 - percent,
                          child: CustomText("LampaTronics",
                              color: AppColors.white, fontsize: 19)),
                      centerTitle: true,
                      elevation: 0.0,
                      // actions: [
                      //   Container(
                      //     width: 150,
                      //     child: Stack(
                      //       alignment: Alignment.bottomCenter,
                      //       fit: StackFit.expand,
                      //       children: [
                      //         Positioned(
                      //           //  top: 10,
                      //           right: actionsXPosition + 2,
                      //           child: Padding(
                      //             padding: const EdgeInsets.only(
                      //               bottom: (kToolbarHeight - 20) / 2,
                      //             ),
                      //             child: OpenContainer(
                      //                 closedElevation: 0,
                      //                 closedColor: Colors.transparent,
                      //                 transitionDuration:
                      //                     const Duration(milliseconds: 700),
                      //                 closedShape: const CircleBorder(),
                      //                 openBuilder: (context, _) =>
                      //                     SearchScreen(),
                      //                 closedBuilder: (context, _) {
                      //                   return Icon(Icons.search);
                      //                   //  IconButton(
                      //                   //   icon:

                      //                   //   onPressed: () => null,
                      //                   // );
                      //                 }),
                      //           ),
                      //         )
                      //       ],
                      //     ),
                      //   ),
                      // ],

                      backgroundColor: Colors.transparent,
                    ),
                    Positioned.directional(
                      textDirection: context.locale == Locale('en', 'US')
                          ? TextDirection.ltr
                          : TextDirection.rtl,
                      bottom: (kToolbarHeight - 30) / 2,
                      end: avatarXPosition,
                      child: CircleAvatar(
                          radius: newAvatarSize / 2,
                          backgroundColor: shrinkOffset == 0
                              ? AppColors.lightGreybackgound
                              : AppColors.white.withOpacity(1 - percent),
                          child: Image.asset(
                            "assets/images/logo.png",
                            //  width: 60,
                          )),
                    )
                  ],
                ),
              ),
            ),
            Opacity(
              opacity: percent,
              // child: Column(mainAxisSize: MainAxisSize.min, children: [
              //   Expanded(
              //       child: Text("Full Name",
              //           style: Theme.of(context).textTheme.headline4)),
              //   Expanded(
              //     child: Text("email@email.com",
              //         style: Theme.of(context).textTheme.headline6),
              //   )
              // ]),
            ),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => extendedHeight;

  @override
  double get minExtent => kToolbarHeight + 30;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
