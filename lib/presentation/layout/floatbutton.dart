import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../core/themes/colors.dart';
import '../screens/cart/cart.dart';
import '../shared/navigator.dart';

class MyFloatActionButton extends StatelessWidget {
  const MyFloatActionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
        // FloatingActionButton(
        //   backgroundColor: AppColors.secondary,
        //   onPressed: () {
        //     navigate(context: context, route: CartScreen());
        //   },
        //   child: Icon(Ionicons.cart_outline),
        // );

        OpenContainer(
            transitionDuration: const Duration(milliseconds: 700),
            closedShape: const CircleBorder(),
            openBuilder: (context, _) => CartScreen(),
            closedBuilder: (context, _) {
              return CircleAvatar(
                radius: 25,
                backgroundColor: Colors.grey.shade100,
                child: Icon(
                  Icons.shopping_cart,
                  color: AppColors.primiry,
                  size: 25,
                ),
              );
            });
  }
}
