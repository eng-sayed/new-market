import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_lampa/core/themes/colors.dart';
import 'package:new_lampa/core/utils/responsive.dart';
import 'package:new_lampa/core/utils/utils.dart';
import 'package:new_lampa/presentation/componants/customtext.dart';
import 'package:new_lampa/presentation/layout/layout.dart';
import 'package:new_lampa/presentation/screens/profile/cubit/cubit.dart';
import 'package:new_lampa/presentation/screens/profile/cubit/states.dart';
import 'package:new_lampa/presentation/screens/profile/widgets/user_data.dart';
import 'package:new_lampa/presentation/shared/needLogin.dart';

import '../../../core/utils/validation.dart';
import '../../componants/expandable_widget.dart';
import '../../componants/loadinganderror.dart';
import '../../shared/login_text_failed.dart';
import '../../shared/navigator.dart';
import 'widgets/custom_clipper.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (Utiles.token.isNotEmpty) {
        ProfileCubit.get(context).getUserDate(context);
      }
    });
    super.initState();
  }

  final passwordContrller = TextEditingController();
  final passwordComContrller = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return NeedLogin(
      child: BlocConsumer<ProfileCubit, ProfileStates>(
          listener: (context, state) {},
          builder: (context, state) {
            final cubit = ProfileCubit.get(context);
            return LoadingAndError(
              isError: state is GetCustomerDataErrorState,
              isLoading: state is GetCustomerDataLoadingState,
              child: Scaffold(
                  appBar: AppBar(
                    //  backgroundColor: Colors.transparent,
                    title: CustomText(
                      "profile".tr(),
                      color: AppColors.white,
                      weight: FontWeight.bold,
                    ),
                  ),
                  body: Stack(children: <Widget>[
                    ClipPath(
                      child: Container(
                        color: AppColors.white,
                      ),
                      clipper: getClipper(),
                    ),
                    SingleChildScrollView(
                        child: Column(
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        Container(
                          width: 90,
                          height: 90,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: Image.asset(
                            'assets/images/images.png', fit: BoxFit.fill,
                            //  fit: BoxFit.cover,
                            width: 90,
                            height: 90,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            Utiles.Username,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        UserDataEdit(),
                        ExpandCardInSide(
                            title: "change pass".tr(),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Form(
                                key: formkey,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: LoginTextField(
                                        color: AppColors.white,
                                        controller: passwordContrller,
                                        hintText: "enter new pass".tr(),
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        validate:
                                            Validation().passwordValidation,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: LoginTextField(
                                          color: AppColors.white,
                                          hintText: "confirm pass".tr(),
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                          validate: (s) {
                                            return Validation()
                                                .confirmPasswordValidation(
                                                    s, passwordContrller.text);
                                          }),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CustomText(
                                        "برجاء العلم ان تغير كلمه المرور سيؤدي الي تسجيل الخروج من التطبيق",
                                        align: TextAlign.center,
                                        color: AppColors.white,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          if (formkey.currentState!
                                              .validate()) {
                                            cubit.updateUserPassword(context,
                                                passwordContrller.text);
                                          }
                                        },
                                        child: CustomText(
                                          "Update Password".tr(),
                                          color: AppColors.primiry,
                                          weight: FontWeight.w700,
                                        ),
                                        style: ElevatedButton.styleFrom(
                                            primary: AppColors.white,
                                            shape: StadiumBorder()),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                      ],
                    ))
                  ])),
            );
          }),
    );
  }
}
