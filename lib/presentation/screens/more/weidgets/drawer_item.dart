import 'package:flutter/material.dart';
import 'package:new_lampa/core/utils/responsive.dart';
import 'package:new_lampa/presentation/componants/customtext.dart';

import '../../../../core/themes/colors.dart';
import '../../../shared/navigator.dart';

class DrawerItem extends StatelessWidget {
  DrawerItem({Key? key, required this.icon, required this.text, this.route})
      : super(
          key: key,
        );
  final IconData icon;
  final String text;
  Widget? route;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigate(context: context, route: route!);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Icon(
              icon,
              color: AppColors.primiry,
              size: 24.fs,
            ),
            SizedBox(
              width: 5,
            ),
            CustomText(text, color: Colors.black)
          ],
        ),
      ),
    );
  }
}
