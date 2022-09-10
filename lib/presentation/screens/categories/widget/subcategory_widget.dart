import 'package:flutter/material.dart';
import 'package:new_lampa/presentation/componants/customtext.dart';
import 'package:new_lampa/presentation/screens/shop/shop.dart';

import '../../../../domain/models/category/woocategory.dart' hide Image;
import '../../../shared/animation_build_widget.dart';
import '../../../shared/navigator.dart';

class SubCategory extends StatefulWidget {
  SubCategory({Key? key, required this.subCategory}) : super(key: key);
  WooProductCategory subCategory;
  @override
  State<SubCategory> createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory> {
  @override
  Widget build(BuildContext context) {
    return AnimationAppearance(
        duration: Duration(milliseconds: 1100),
        curve: Curves.fastOutSlowIn,
        alignment: Alignment.bottomLeft,
        child: GestureDetector(
          onTap: () {
            navigate(
                context: context,
                route: ShopScreen(
                  title: widget.subCategory.name!,
                  categoryId: widget.subCategory.id!,
                  // name: widget.subCategory.name!,
                ));
            //   print(22);
          },
          child: Column(
            children: [
              Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 3,
                child: SizedBox(
                  width: 100,
                  height: 90,
                  child: widget.subCategory.image == null
                      ? Image.asset(
                          'assets/images/PROF.png',
                          fit: BoxFit.fill,
                        )
                      : Image.network(
                          widget.subCategory.image!.guid!,
                          fit: BoxFit.fill,
                        ),
                ),
              ),
              CustomText(widget.subCategory.name!.replaceAll("amp;", " "),
                  fontsize: 12, maxLines: 2, overflow: TextOverflow.ellipsis),
            ],
          ),
        ));
  }
}
