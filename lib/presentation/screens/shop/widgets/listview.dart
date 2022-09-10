import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../domain/models/product/wooproduct.dart';
import '../../../componants/customtext.dart';
import '../../../componants/myLoading.dart';
import '../../../componants/product_list_item.dart';
import '../../../componants/product_widget.dart';
import '../../../shared/empty_widget.dart';
import '../cubit/cubit.dart';

class ListViewProducts extends StatelessWidget {
  const ListViewProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = ShopCubit.get(context);
    return PagedListView.separated(
      pagingController: cubit.pagingController,
      builderDelegate: PagedChildBuilderDelegate<WooProduct>(
        firstPageProgressIndicatorBuilder: (context) =>
            MyLoading.loadingWidget(),
        noItemsFoundIndicatorBuilder: (context) => EmptyWidget(),
        // animateTransitions: true,
        itemBuilder: (_, item, index) {
          return ProductListItem(
            product: item,
          );
        },
      ),
      separatorBuilder: (context, index) => SizedBox(),
    );
  }
}
