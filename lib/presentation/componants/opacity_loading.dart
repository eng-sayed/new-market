import 'package:flutter/material.dart';

import 'loader.dart';

class OpacityLoadingWidget extends StatelessWidget {
  const OpacityLoadingWidget(
      {Key? key, required this.child, required this.loadingCondition})
      : super(key: key);
  final Widget child;
  final bool loadingCondition;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (loadingCondition)
          Container(
            color: Colors.white.withOpacity(0.5),
            child: Center(
                child: ColorLoader3(
              radius: 20,
              dotRadius: 5,
            )),
          ),
      ],
    );
  }
}
