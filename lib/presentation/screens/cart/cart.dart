import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_lampa/core/utils/responsive.dart';

import '../../../core/themes/colors.dart';
import '../../../core/utils/utils.dart';
import '../../componants/customtext.dart';
import '../../componants/loadinganderror.dart';
import '../../shared/empty_widget.dart';
import '../../shared/navigator.dart';
import '../checkout/checkout.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
import 'widgets/cart_item.dart';
import 'widgets/requirdLogin.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    final cubit = CartCubit.get(context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await cubit.getDataCart(context: context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = CartCubit.get(context);
          return LoadingAndError(
            isError: state is CartGetDataError,
            isLoading: state is CartGetDataLoading,
            child: Scaffold(
                floatingActionButton: FloatingActionButton(
                  child: Icon(Icons.whatsapp),
                  onPressed: () {
                    Utiles().openwhatsapp(context);
                  },
                ),
                appBar: AppBar(
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Image.asset(
                            "assets/images/logo.png",
                            //  width: 60,
                          )),
                    ),
                  ],
                  //elevation: 0,
                  title: CustomText(
                    "cart".tr(),
                    color: AppColors.white,
                    weight: FontWeight.bold,
                    fontsize: 18,
                  ),
                ),
                resizeToAvoidBottomInset: false,
                body: cubit.cart.wooCartitems?.isEmpty ?? true
                    ? EmptyWidget()
                    : ListView.builder(
                        itemBuilder: (context, index) {
                          return CartItem(
                            key: UniqueKey(),
                            wooCartitems: cubit.cart.wooCartitems![index],
                          );
                        },
                        itemCount: cubit.cart.wooCartitems?.length ?? 0),
                bottomNavigationBar: Container(
                  color: Colors.grey.shade100,
                  height: 105.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 30),
                              child: CustomText(
                                "total".tr(),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 30),
                              child: CustomText(
                                cubit.cartTotal(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      MaterialButton(
                        onPressed: () async {
                          if (Utiles.token.isNotEmpty) {
                            if (cubit.cart.wooCartitems!.length > 0) {
                              navigate(context: context, route: Checkout());
                            } else {
                              //  showSnack(context, "emptycart".tr());
                            }
                          } else {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    RequirdLogin());
                          }
                        },
                        color: AppColors.primiry,
                        padding: EdgeInsets.only(
                            top: 12, left: 60, right: 60, bottom: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(24))),
                        child: CustomText(
                          "checkout".tr(),
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                  margin: EdgeInsets.only(top: 16, bottom: 20),
                )),
          );
        });
  }
}
