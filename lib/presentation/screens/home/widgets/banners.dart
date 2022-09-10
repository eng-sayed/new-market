// import 'package:threefood/core/themes/colors.dart';
// import 'package:threefood/core/utils/responsive.dart';
// import 'package:threefood/domain/models/wooslider.dart/wooslider.dart';
// import 'package:threefood/presentation/componants/customtext.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:threefood/presentation/shared/network_image.dart';

// class BannersWidget extends StatefulWidget {
//   const BannersWidget(
//       {Key? key, required this.banners, required this.centerText})
//       : super(key: key);
//   final List<WooMobileSlider> banners;
//   final bool centerText;
//   @override
//   State<BannersWidget> createState() => _BannersWidgetState();
// }

// class _BannersWidgetState extends State<BannersWidget> {
//   int currentIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: Alignment.bottomLeft,
//       children: [
//         CarouselSlider(
//           items: widget.banners.map((banner) {
//             return Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//               child: SizedBox(
//                 width: double.infinity,
//                 child: Card(
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15)),
//                   clipBehavior: Clip.hardEdge,
//                   child: Stack(
//                     fit: StackFit.expand,
//                     children: [
//                       NetworkImagesWidgets(
//                         banner.images?.guid ?? '',
//                         fit: BoxFit.cover,
//                       ),
//                       // Container(
//                       //   color: AppColors.primiry.withOpacity(0.5),
//                       // ),
//                       // widget.centerText ? offersBanner() : discountBanner(),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           }).toList(),
//           options: CarouselOptions(
//               height: 250.h,
//               initialPage: 0,
//               viewportFraction: 1,
//               enableInfiniteScroll: true,
//               reverse: false,
//               autoPlay: true,
//               autoPlayAnimationDuration: const Duration(seconds: 3),
//               autoPlayCurve: Curves.fastOutSlowIn,
//               scrollDirection: Axis.horizontal,
//               onPageChanged: (s, c) {
//                 currentIndex = s;
//                 setState(() {});
//               }),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(bottom: 10),
//           child: Align(
//             alignment: Alignment.center,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: widget.banners.map(
//                 (e) {
//                   var x = widget.banners.indexOf(e);
//                   return Container(
//                     width: 8.0,
//                     height: 8.0,
//                     margin:
//                         EdgeInsets.symmetric(vertical: 8.0, horizontal: 2.0),
//                     decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: currentIndex == x
//                             ? AppColors.white
//                             : AppColors.secondary),
//                   );
//                 },
//               ).toList(),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   // Padding offersBanner() {
//   //   return Padding(
//   //     padding: const EdgeInsets.only(right: 10),
//   //     child: Align(
//   //       alignment: Alignment.center,
//   //       child: SizedBox(
//   //         height: 190.h,
//   //         width: 240.w,
//   //         child: Card(
//   //           shape:
//   //               RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
//   //           color: AppColors.primiry.withOpacity(0.4),
//   //           child: Padding(
//   //             padding: const EdgeInsets.all(8.0),
//   //             child: Column(
//   //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//   //               children: <Widget>[
//   //                 Image.asset(
//   //                   "assets/images/logo.png",
//   //                   width: 80,
//   //                 ),
//   //                 SizedBox(
//   //                   height: 10,
//   //                 ),
//   //                 CustomText("عروض تنظيف البشره",
//   //                     align: TextAlign.center,
//   //                     textStyleEnum: TextStyleEnum.title,
//   //                     color: AppColors.white,
//   //                     weight: FontWeight.w700),
//   //                 SizedBox(
//   //                   height: 5,
//   //                 ),
//   //                 Card(
//   //                   shape: StadiumBorder(),
//   //                   color: AppColors.primiry,
//   //                   child: Padding(
//   //                     padding: const EdgeInsets.symmetric(
//   //                         horizontal: 10, vertical: 5),
//   //                     child: CustomText("احجز الأن",
//   //                         color: Colors.white, weight: FontWeight.w400),
//   //                   ),
//   //                 )
//   //               ],
//   //             ),
//   //           ),
//   //         ),
//   //       ),
//   //     ),
//   //   );
//   // }

//   // Padding discountBanner() {
//   //   return Padding(
//   //     padding: const EdgeInsets.only(right: 10),
//   //     child: Align(
//   //       alignment: Alignment.centerRight,
//   //       child: SizedBox(
//   //         height: 210.h,
//   //         width: 130.w,
//   //         child: Card(
//   //           shape:
//   //               RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
//   //           color: AppColors.primiry.withOpacity(0.4),
//   //           child: Padding(
//   //             padding: const EdgeInsets.all(8.0),
//   //             child: Column(
//   //               children: <Widget>[
//   //                 Image.asset(
//   //                   "assets/images/logo.png",
//   //                   width: 80,
//   //                 ),
//   //                 SizedBox(
//   //                   height: 10,
//   //                 ),
//   //                 CustomText("خصم حتي 20 %",
//   //                     align: TextAlign.center,
//   //                     textStyleEnum: TextStyleEnum.title,
//   //                     color: AppColors.white,
//   //                     weight: FontWeight.w700),
//   //                 SizedBox(
//   //                   height: 5,
//   //                 ),
//   //                 Card(
//   //                   shape: StadiumBorder(),
//   //                   color: AppColors.primiry,
//   //                   child: Padding(
//   //                     padding: const EdgeInsets.symmetric(
//   //                         horizontal: 10, vertical: 5),
//   //                     child: CustomText("احجز الأن",
//   //                         color: Colors.white, weight: FontWeight.w400),
//   //                   ),
//   //                 )
//   //               ],
//   //             ),
//   //           ),
//   //         ),
//   //       ),
//   //     ),
//   //   );

// }
