import 'package:flutter/material.dart';
import 'package:new_lampa/core/utils/responsive.dart';

import '../../core/themes/colors.dart';

enum TextStyleEnum {
  normal,
  title,
  caption,
}

class CustomText extends StatelessWidget {
  TextStyle getTextStyle(TextStyleEnum textStyleEnum,
      {Color? color,
      double? fontsize,
      String? fontFamily,
      TextOverflow? overflow,
      TextDecoration? decoration,
      FontWeight? weight}) {
    switch (textStyleEnum) {
      case TextStyleEnum.title:
        return TextStyle(
                fontSize: 25.fs,
                color: AppColors.black,
                fontFamily: "Tajawal",
                fontWeight: FontWeight.w500)
            .copyWith(
                decoration: decoration,
                color: color ?? AppColors.black,
                fontWeight: weight,
                fontSize: fontsize,
                overflow: overflow ?? TextOverflow.visible,
                fontFamily: fontFamily ?? "Tajawal");
      case TextStyleEnum.caption:
        return TextStyle(
                fontSize: 12.fs,
                color: AppColors.black,
                fontFamily: "Tajawal",
                fontWeight: FontWeight.w300)
            .copyWith(
                decoration: decoration,
                color: color ?? AppColors.black,
                fontWeight: weight,
                fontSize: fontsize,
                overflow: overflow ?? TextOverflow.visible,
                fontFamily: fontFamily ?? "Tajawal");

      default:
        return TextStyle(
                fontSize: 17.fs,
                color: AppColors.black,
                fontFamily: "Tajawal",
                fontWeight: FontWeight.w500)
            .copyWith(
                decoration: decoration,
                color: color ?? AppColors.black,
                fontWeight: weight,
                fontSize: fontsize,
                overflow: overflow ?? TextOverflow.visible,
                fontFamily: fontFamily ?? "Tajawal");
    }
  }

  const CustomText(
    this.text, {
    Key? key,
    this.textStyleEnum,
    this.color,
    this.fontsize,
    this.weight,
    this.fontFamily,
    this.align,
    this.decoration,
    this.overflow,
    this.maxLines,
  }) : super(key: key);
  final String text;
  final TextStyleEnum? textStyleEnum;
  final Color? color;
  final double? fontsize;
  final String? fontFamily;
  final TextOverflow? overflow;
  final TextDecoration? decoration;
  final TextAlign? align;
  final int? maxLines;
  final FontWeight? weight;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      textAlign: align,
      style: getTextStyle(textStyleEnum ?? TextStyleEnum.normal,
          color: color,
          fontsize: fontsize,
          fontFamily: fontFamily,
          overflow: overflow,
          decoration: decoration,
          weight: weight),
    );
  }
}
