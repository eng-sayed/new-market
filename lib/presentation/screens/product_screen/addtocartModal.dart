import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:new_lampa/core/utils/responsive.dart';

import '../../../core/themes/colors.dart';
import '../../../core/utils/alerts.dart';
import '../../../domain/models/product/wooproduct.dart';
import '../../componants/customtext.dart';
import '../../componants/textfield.dart';
import '../../shared/network_image.dart';
import '../cart/cubit/cubit.dart';

class AddToCart extends StatefulWidget {
  AddToCart({required this.url, required this.wooProduct});
  String url;
  WooProduct wooProduct;
  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  int count = 1;
  double? price;
  @override
  void initState() {
    // TODO: implement initState+
    price = double.parse(widget.wooProduct.price ?? '0');
    // Provider.of<CartController>(context, listen: false).cartState =
    //     CartState.done;
    super.initState();
  } // price = widget.wooProduct!.price.toInt();

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 15, left: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              width: 100.fs,
                              height: 100.fs,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                // ignore: unnecessary_new

                                border: Border.all(
                                  width: 1,
                                  color: AppColors.primiry,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              child: NetworkImagesWidgets(
                                  widget.wooProduct.images![0].src!,
                                  fit: BoxFit.cover)),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  CustomText(widget.wooProduct.name ?? '',
                                      fontsize: 18.fs,
                                      color: Colors.black,
                                      weight: FontWeight.bold),
                                  CustomText(
                                      '${double.parse(widget.wooProduct.price ?? "0")} ${"sr".tr()}',
                                      fontsize: 16.fs,
                                      color: Colors.black,
                                      weight: FontWeight.w800),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText('total'.tr(),
                            fontsize: 18.fs,
                            color: Colors.black,
                            weight: FontWeight.bold),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomText(price.toString(),
                              fontsize: 18.fs,
                              color: AppColors.primiry,
                              weight: FontWeight.w700),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                          onPressed: () {
                            setState(() {
                              count > 1 ? count-- : null;

                              price =
                                  double.parse(widget.wooProduct.price ?? "0") *
                                      count;
                            });
                          },
                          icon: Icon(
                            Icons.remove,
                            size: 20,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("enternum".tr()),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0))),
                                  contentPadding: EdgeInsets.only(top: 10.0),
                                  content: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: DefaultTextField(
                                      textColor: AppColors.black,
                                      keyboardType: TextInputType.number,
                                      validate: (s) {},
                                      controller: controller,
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text("OK".tr()),
                                      onPressed: () {
                                        Navigator.pop(context, controller.text);
                                      },
                                    ),
                                    TextButton(
                                      child: Text("Cancel".tr()),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                );
                              },
                            ).then((val) {
                              setState(() {
                                print(val.runtimeType);
                                count = int.parse(val);
                                price = double.parse(
                                        widget.wooProduct.price ?? "0") *
                                    count;
                              });
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            padding: const EdgeInsets.only(
                                bottom: 2, right: 12, left: 12, top: 2),
                            child: Text(
                              count.toString(),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            count++;
                            //     price = int.parse(widget.wooProduct!.price!);
                            price =
                                double.parse(widget.wooProduct.price ?? "0") *
                                    count;
                            setState(() {});

                            print(price);
                          },
                          icon: Icon(
                            Icons.add,
                            size: 20,
                            color: Colors.grey.shade700,
                          ),
                        )
                      ],
                    ),
                  ],
                ), //TODO

                ElevatedButton(
                    style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                    onPressed: () async {
                      if (widget.wooProduct.stockStatus == 'instock') {
                        await CartCubit.get(context).addToCart(context,
                            product: widget.wooProduct, quantity: count);
                        Navigator.pop(context);
                      } else {
                        (Navigator.pop(context));
                        OverLays.snack(context,
                            text: "outstock".tr(), state: SnakState.failed);
                      }
                    },
                    child: CustomText(
                      'addtocart'.tr(),
                      color: AppColors.white,
                    ))

                // MaterialButtonDesign(
                //     color: AppColors.primiry,
                //     label: 'addtocart'.tr(),
                //     minWidth: 150.w,
                //     pressed: () {
                //       if (widget.wooProduct.stockStatus == 'instock') {
                //         value.addToCart(widget.wooProduct, count, context);
                //       } else {
                //         (Navigator.pop(context));
                //         showSnack(context, "outstock".tr());
                //       }
                //     }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
