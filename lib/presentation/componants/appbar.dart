import 'package:flutter/material.dart';

import '../../core/themes/colors.dart';

AppBar customAppBar({bool showLeading = false, bool showActions = false}) {
  return AppBar(
    backgroundColor: AppColors.lightGrey,
    title: Image.asset("name"),
    actions: showActions ? [Icon(Icons.shopping_bag)] : null,
    leading: showLeading ? Icon(Icons.menu) : null,
  );
}
