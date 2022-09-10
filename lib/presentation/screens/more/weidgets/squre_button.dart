import 'package:flutter/material.dart';
import 'package:new_lampa/core/utils/responsive.dart';
import 'package:new_lampa/presentation/componants/customtext.dart';

import '../../../../core/themes/colors.dart';

class SqureButton extends StatelessWidget {
  const SqureButton(
      {Key? key, required this.icon, this.onTap, required this.text})
      : super(key: key);
  final VoidCallback? onTap;
  final String text;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          color: AppColors.primiry,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.all(12.0.fs),
              child: Icon(
                icon,
                color: Colors.white,
                size: 25.fs,
              ),
            ),
          ),
        ),
        CustomText(text, fontsize: 13.fs)
      ],
    );
  }
}
