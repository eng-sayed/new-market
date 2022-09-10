import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lottie/lottie.dart';

import '../../../../domain/models/product/wooproduct.dart';
import '../../../componants/customtext.dart';
import '../../../componants/myLoading.dart';
import '../../../componants/product_widget.dart';
import '../../../shared/empty_widget.dart';
import '../cubit/cubit.dart';

class GridViewProducts extends StatelessWidget {
  const GridViewProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = ShopCubit.get(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: PagedGridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisExtent: 200),
        pagingController: cubit.pagingController,
        builderDelegate: PagedChildBuilderDelegate<WooProduct>(
          firstPageProgressIndicatorBuilder: (context) => Padding(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyLoading.loadingWidget(),
              ],
            ),
          ),
          noItemsFoundIndicatorBuilder: (context) => SizedBox(
            child: EmptyWidget(),
          ),
          // animateTransitions: true,
          itemBuilder: (_, item, index) {
            return ProductWidget(
              isTrend: false,
              products: item,
            );
          },
        ),
      ),
    );
  }
}
