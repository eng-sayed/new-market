import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:new_lampa/core/utils/responsive.dart';

import '../../../../core/themes/colors.dart';
import '../../../../domain/models/cart/woocart.dart';
import '../../../componants/customtext.dart';
import '../../../shared/network_image.dart';
import '../cubit/cubit.dart';

class CartItem extends StatefulWidget {
  CartItem({Key? key, required this.wooCartitems}) : super(key: key);
  WooCartitems wooCartitems;
  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  late int count;
  late double price;
  double? totalPrice;
  @override
  void initState() {
    count = widget.wooCartitems.quantity!;
    price = double.parse(widget.wooCartitems.wooItemPrices!.price!);
    totalPrice = count * price;
    super.initState();
  }

  refreshTotalPrice() {
    setState(() {
      totalPrice = count * price;
    });
  }

  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 3,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                          margin: EdgeInsets.only(
                              right: 8, left: 8, top: 8, bottom: 8),
                          width: 80.fs,
                          height: 80.fs,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(14)),
                            color: Colors.white,
                          ),
                          child:
                              widget.wooCartitems.wooCartItemImages!.isNotEmpty
                                  ? NetworkImagesWidgets(
                                      widget.wooCartitems.wooCartItemImages!
                                          .first.src!,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      "assets/images/placeholder.png",
                                      fit: BoxFit.fill,
                                    )),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 7,
                          ),
                          CustomText(
                            (widget.wooCartitems.name ?? "")
                                .replaceAll("&#8211;", "-"),
                            maxLines: 2,
                            color: AppColors.primiry,
                            weight: FontWeight.w500,
                          ),
                          CustomText(
                            price.toString() + " " + "sr".tr(),
                            weight: FontWeight.w700,
                            color: AppColors.black,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              CustomText(
                                (totalPrice).toString() + " " + "sr".tr(),
                                color: AppColors.black,
                                weight: FontWeight.w600,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  IconButton(
                                    onPressed: () {
                                      count > 1 ? count-- : null;
                                      refreshTotalPrice();
                                    },
                                    icon: Icon(
                                      Icons.remove,
                                      size: 20,
                                      color: AppColors.primiry,
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
                                            contentPadding:
                                                EdgeInsets.only(top: 10.0),
                                            content: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextField(
                                                keyboardType:
                                                    TextInputType.number,
                                                controller: controller,
                                              ),
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                child: Text("OK".tr()),
                                                onPressed: () {
                                                  Navigator.pop(
                                                      context, controller.text);
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
                                          totalPrice = double.parse(widget
                                                  .wooCartitems
                                                  .wooItemPrices!
                                                  .price!) *
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
                                          bottom: 2,
                                          right: 12,
                                          left: 12,
                                          top: 2),
                                      child: CustomText(
                                        count.toString(),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      count++;
                                      refreshTotalPrice();
                                    },
                                    icon: Icon(
                                      Icons.add,
                                      size: 20,
                                      color: AppColors.primiry,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
                count == widget.wooCartitems.quantity!
                    ? SizedBox()
                    : Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Card(
                          shape: StadiumBorder(),
                          clipBehavior: Clip.hardEdge,
                          color: AppColors.primiry,
                          child: InkWell(
                            onTap: () {
                              CartCubit.get(context).updateCartItem(context,
                                  key: widget.wooCartitems.key ?? "",
                                  id: widget.wooCartitems.id ?? 0,
                                  product: widget.wooCartitems,
                                  quantity: count);
                            },
                            customBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: SizedBox(
                              width: 80,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomText("confirm".tr(),
                                    align: TextAlign.center,
                                    color: Colors.white,
                                    fontsize: 14.fs),
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.only(bottom: 10),
          child: InkWell(
            onTap: () async {
              CartCubit.get(context).removeFromCart(
                context,
                key: widget.wooCartitems.key ?? "",
                id: widget.wooCartitems.id ?? 0,
              );
            },
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 24,
                height: 24,
                alignment: Alignment.center,
                margin: EdgeInsets.only(right: 10, top: 8),
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 20,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    color: AppColors.primiry),
              ),
            ),
          ),
        )
      ],
    );
    ;
  }
}
