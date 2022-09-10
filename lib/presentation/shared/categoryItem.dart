import 'package:flutter/material.dart';
import 'package:new_lampa/core/utils/responsive.dart';
import 'package:new_lampa/domain/models/category/woocategory.dart';
import 'package:new_lampa/presentation/screens/shop/shop.dart';
import 'package:new_lampa/presentation/shared/navigator.dart';

import '../../core/themes/colors.dart';
import '../componants/customtext.dart';
import 'network_image.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({Key? key, required this.categoriesModel})
      : super(key: key);
  final WooProductCategory categoriesModel;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: CircleBorder(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox.square(
            dimension: 40,
            child: Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ), //  border: Border.all(color: AppColors.secondary, width: 2)),
              child: NetworkImagesWidgets(
                categoriesModel.image?.guid ?? '',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 10),
          CustomText(
            categoriesModel.name ?? '',
            color: AppColors.black,
            fontsize: 12,
            align: TextAlign.center,
            weight: FontWeight.w500,
          ),
        ],
      ),
      onTap: () {
        navigate(
          context: context,
          route: ShopScreen(
            title: categoriesModel.name ?? "",
            categoryId: categoriesModel.id,
          ),
        );
      },
    );
  }
}
