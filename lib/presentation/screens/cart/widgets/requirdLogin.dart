import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../componants/customtext.dart';
import '../../../shared/navigator.dart';
import '../../auth/screens/auth_screen.dart';

class RequirdLogin extends StatelessWidget {
  const RequirdLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      // title: Text('Login'),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Center(
            child: CustomText(
              "mustlogin".tr(),
            ),
          )
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  navigate(context: context, route: AuthScreen());
                },
                child: (CustomText("login".tr()))),
          ],
        ),
      ],
    );
  }
}
