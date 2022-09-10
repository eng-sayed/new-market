import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:new_lampa/core/utils/responsive.dart';

import '../../core/themes/colors.dart';
import 'customtext.dart';

class ExpandCardInSide extends StatefulWidget {
  ExpandCardInSide(
      {Key? key,
      required this.child,
      required this.title,
      this.color,
      this.isexpand,
      this.titlecolor})
      : super(key: key);
  String title;
  Widget child;
  Color? color;
  Color? titlecolor;
  bool? isexpand;
  @override
  _ExpandCardInSideState createState() => _ExpandCardInSideState();
}

class _ExpandCardInSideState extends State<ExpandCardInSide> {
  late bool isopen;
  @override
  void initState() {
    isopen = widget.isexpand ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Card(
          elevation: 4,
          color: widget.color ?? AppColors.primiry,
          // elevation: 12,
          child: Column(
            children: [
              ListTile(
                title: CustomText(
                  widget.title,
                  color: widget.titlecolor ?? AppColors.white,
                  fontsize: 15.fs,
                  weight: FontWeight.bold,
                ),
                trailing: Container(
                  height: 30,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: isopen ? AppColors.primiry : AppColors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80.0)),
                    ),
                    child: CustomText(
                      isopen ? "hide".tr() : "show".tr(),
                      color: isopen ? AppColors.white : AppColors.primiry,
                    ),
                    onPressed: () {
                      isopen = !isopen;
                      setState(() {});
                    },
                  ),
                ),
              ),
              AnimatedCrossFade(
                duration: Duration(milliseconds: 500),
                crossFadeState: isopen
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                firstChild: widget.child,
                secondChild: SizedBox(
                  width: double.infinity,
                ),
              ),
            ],
          ),
        ),
      ],
    );
    ;
  }
}
