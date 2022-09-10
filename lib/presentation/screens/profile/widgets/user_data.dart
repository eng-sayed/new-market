import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:new_lampa/core/themes/colors.dart';
import 'package:new_lampa/core/utils/responsive.dart';
import 'package:new_lampa/presentation/componants/customtext.dart';

import '../../../../core/utils/validation.dart';
import '../../../shared/login_text_failed.dart';
import '../cubit/cubit.dart';

class UserDataEdit extends StatefulWidget {
  const UserDataEdit({
    Key? key,
  }) : super(key: key);

  @override
  State<UserDataEdit> createState() => _UserDataEditState();
}

class _UserDataEditState extends State<UserDataEdit> {
  String? city;
  @override
  void initState() {
    // firstNameBilling = TextEditingController(
    //     text: WooCommerce.currentCustommer!.firstName ?? "");
    // lastNameBilling = TextEditingController(
    //     text: WooCommerce.currentCustommer!.lastName ?? "");
    // emailBilling =
    //     TextEditingController(text: WooCommerce.currentCustommer!.email ?? "");
    // adressBilling = TextEditingController(
    //     text: WooCommerce.currentCustommer!.billing!.address1 ?? "");
    // adressShipping = TextEditingController(
    //     text: WooCommerce.currentCustommer!.shipping!.address1 ?? "");
    // // postCodeBilling = TextEditingController(
    // //     text: WooCommerce.currentCustommer!.billing!.postcode ?? "");
    // phoneNumberBilling = TextEditingController(
    //     text: WooCommerce.currentCustommer!.billing!.phone ?? "");

    // city = WooCommerce.currentCustommer!.billing!.city;
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = ProfileCubit.get(context);

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          //  title: "profile".tr(),
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CustomText("name".tr(), fontsize: 18.fs, color: Colors.black),
                  Row(
                    children: [
                      Expanded(
                        child: LoginTextField(
                          controller: cubit.firstNameBilling,
                          keyboardType: TextInputType.text,
                          validate: (s) {},
                          hintText: "firstname".tr(),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: LoginTextField(
                          controller: cubit.lastNameBilling,
                          keyboardType: TextInputType.text,
                          validate: (s) {},
                          hintText: "lastname".tr(),
                        ),
                      ),
                    ],
                  ),
                  CustomText("email".tr(),
                      fontsize: 18.fs, color: Colors.black),
                  DefaultTextField(
                    enable: false,
                    controller: cubit.emailBilling,
                    keyboardType: TextInputType.text,
                    validate: Validation().defaultValidation,
                    hintText: "xxxx@gmail.com",
                  ),
                  CustomText("phone".tr(),
                      fontsize: 18.fs, color: Colors.black),
                  DefaultTextField(
                    enable: false,
                    suffixIcon: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          "+966",
                          weight: FontWeight.bold,
                          color: AppColors.primiry,
                        ),
                      ],
                    ),
                    controller: cubit.phoneNumberBilling,
                    keyboardType: TextInputType.text,
                    validate: (s) {},
                    hintText: "01XXXXXXXXX",
                  ),

                  CustomText("adress".tr(),
                      fontsize: 18.fs, color: Colors.black),
                  LoginTextField(
                    controller: cubit.adressBilling,
                    keyboardType: TextInputType.text,
                    validate: (s) {},
                    hintText: "15 st xxxxxxxxx",
                  ),
                  CustomText("shippingadress".tr(),
                      fontsize: 18.fs, color: Colors.black),
                  LoginTextField(
                    controller: cubit.adressShipping,
                    keyboardType: TextInputType.text,
                    validate: (s) {},
                    hintText: "15 st xxxxxxxxx",
                  ),
                  // CustomText("PostCode /Zip", fontsize: 18.fs, color: Colors.white),
                  // CustomTextField(
                  //   keyboardType: TextInputType.text,
                  //   validate: Validation().defaultValidation,
                  //   hintText: "1355",
                  // ),

                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          primary: AppColors.primiry,
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            cubit.updateUserData(context);
                          }
                        },
                        child: CustomText(
                          "save".tr(),
                          color: AppColors.white,
                          weight: FontWeight.bold,
                        )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChangeLang extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () {
            context.locale = Locale('ar', 'EG');
            // navigateReplacement(context: context, route: Home());

            // isarabic = true;
            // setState(() {});
          },
          child: Row(
            children: <Widget>[
              CustomText("العربيه"),
              Spacer(),
              context.locale != Locale('en', 'US')
                  ? Icon(Icons.done)
                  : SizedBox()
            ],
          ),
        ),
        InkWell(
          onTap: () {
            context.locale = Locale('en', 'US');
            // navigateReplacement(context: context, route: Home());
            // isarabic = false;
            // setState(() {});
          },
          child: Row(
            children: <Widget>[
              CustomText("English"),
              Spacer(),
              context.locale == Locale('en', 'US')
                  ? Icon(Icons.done)
                  : SizedBox()
            ],
          ),
        ),
      ],
    );
  }
}
