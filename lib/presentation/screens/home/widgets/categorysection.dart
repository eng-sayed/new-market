// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:threefood/domain/models/category/woocategory.dart';

// import '../../../../core/themes/colors.dart';
// import '../../../../domain/models/categories/categories_model.dart';
// import '../../../componants/customtext.dart';
// import '../../../componants/loadinganderror.dart';
// import '../../../layout/cubit/layout_cubit.dart';
// import '../../../shared/categoryItem.dart';
// import '../cubit/cubit.dart';

// class CategoriesSection extends StatelessWidget {
//   const CategoriesSection({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final layoutCubit = HomeLayoutCubit.get(context);
//     final homeCubit = HomePageCubit.get(context);

//     return LoadingAndError(
//       isError: false,
//       isLoading: false,
//       child: Container(
//         color: AppColors.primiry.withOpacity(0.04),
//         child: Column(
//           children: <Widget>[
//             ListTile(
//               onTap: () {
//                 layoutCubit.tabController.animateTo(1);
//               },
//               title: CustomText("category".tr(),
//                   textStyleEnum: TextStyleEnum.title),
//               subtitle: CustomText("pro as section".tr(),
//                   textStyleEnum: TextStyleEnum.normal,
//                   color: AppColors.darkGrey),
//               trailing: Card(
//                 elevation: 0,
//                 color: Colors.transparent,
//                 shape: StadiumBorder(
//                     side: BorderSide(width: 1, color: AppColors.primiry)),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: CustomText("showall".tr(), color: AppColors.primiry),
//                 ),
//               ),
//             ),
//             // check if category is not empty
//             //[].getRange(0,3);

//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: List.generate(
//                   homeCubit.firstRow.length,
//                   (index) => Expanded(
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: CategoryItem(
//                               categoriesModel: homeCubit.firstRow[index]),
//                         ),
//                       )),
//             ),
//             SizedBox(height: 10),
//             // check if category is > 4
//             //[].getRange(3,7);
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: List.generate(
//                   homeCubit.secoundRow.length,
//                   (index) => Expanded(
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: CategoryItem(
//                             categoriesModel: homeCubit.secoundRow[index],
//                           ),
//                         ),
//                       )),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
