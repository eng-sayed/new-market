import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:new_lampa/core/utils/responsive.dart';
import 'package:new_lampa/core/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/themes/colors.dart';
import '../../../domain/models/product/wooproduct.dart';
import '../../componants/customtext.dart';
import '../../componants/loadinganderror.dart';
import '../../componants/product_widget.dart';
import '../../componants/shimer_loading_items.dart';
import '../../componants/textfield.dart';
import '../../shared/defaultappbar.dart';
import '../../shared/navigator.dart';
import '../../shared/network_image.dart';
import '../cart/cart.dart';
import '../favourite_button/fav_button.dart';
import 'addtocartModal.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ProductScreen extends StatefulWidget {
  ProductScreen({Key? key, this.product}) : super(key: key);

  WooProduct? product;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  CarouselController imagesController = CarouselController();
  List<WooProduct> relatedProducts = [];
  String url = "";
  List productImages = [];
  //WooProduct wooProduct = WooProduct();
  List<WooProduct> related = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final cubit = ProductScreenCubit.get(context);
      // wooProduct =
      //     await cubit.getProductById(context, widget.productId) ?? WooProduct();
      print(widget.product!.id);
      related = await cubit.getRelatedProductBy(
              context, widget.product!.relatedIds!) ??
          WooProduct();
      productImages = widget.product!.images ?? [];
      print("onSale" + widget.product!.onSale.toString());
    });

    super.initState();
  }

  Widget smallImage({required String? imageUrl, required int index}) {
    return GestureDetector(
      onTap: () {
        imagesController.animateToPage(index);
        setState(() {});
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.primiry,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        height: 40,
        width: 40,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(imageUrl ?? "", fit: BoxFit.contain)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductScreenCubit, ProductScreenStates>(
        listener: (context, state) {
      print(state.toString());
    }, builder: (context, state) {
      return Material(
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
            title: Text(state is ProductScreenPageGetAdsLoadingState
                ? ''
                : widget.product!.name ?? ""),
            backgroundColor: AppColors.primiry,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  // navigate(context: context, route: CartPage());
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
          ),
          // floatingActionButton: BottomAddToCart(),
          bottomNavigationBar: BottomAppBar(
            color: Colors.transparent,
            clipBehavior: Clip.hardEdge, elevation: 0,
            //  shape: const CircularNotchedRectangle(),
            child: Container(
              height: 55,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  color: AppColors.primiry,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {
                        navigate(context: context, route: CartScreen());
                      },
                      icon: Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(), primary: AppColors.white),
                      onPressed: () {
                        showModalBottomSheet<void>(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(25),
                              topLeft: Radius.circular(25),
                            ),
                          ),
                          backgroundColor: Colors.white,
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 300.h,
                              width: double.infinity,
                              child: AddToCart(
                                wooProduct: widget.product!,
                                url: url,
                              ),
                            );
                          },
                        );
                      },
                      child: CustomText(
                        'addtocart'.tr(),
                        color: AppColors.primiry,
                        weight: FontWeight.bold,
                      ),
                    ),
                  ]),
            ),
          ),

          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: 300,
                        width: double.infinity,
                        child: CarouselSlider(
                            carouselController: imagesController,
                            items: productImages
                                .map(
                                  (e) => NetworkImagesWidgets(e.src),
                                )
                                .toList(),
                            options: CarouselOptions(viewportFraction: 1)),
                        //   NetworkImagesWidgets(url: url, fit: BoxFit.fill),
                      ),
                      widget.product!.stockStatus == 'outofstock'
                          ? SizedBox()
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  FavouriteButton(
                                    product: widget.product!,
                                  )
                                ],
                              ),
                            ),
                      widget.product!.stockStatus == 'outofstock'
                          ? SizedBox(
                              height: 300,
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Container(
                                  child: Center(
                                    child:
                                        Image.asset('assets/images/sold.png'),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                      widget.product!.stockStatus == 'outofstock'
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  FavouriteButton(
                                    product: widget.product!,
                                  )
                                ],
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: productImages.map(
                          (e) {
                            final index = productImages.indexOf(e);
                            return smallImage(imageUrl: e.src, index: index);
                          },
                        ).toList()),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      // TODO  textDirection: TextDirection.LTR,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(widget.product!.name ?? "",
                            fontsize: 20.fs,
                            //    textDirection: TextDirection.ltr,
                            color: Colors.black,
                            weight: FontWeight.bold),
                        !(widget.product!.onSale ?? false)
                            ? CustomText(
                                "${double.tryParse(widget.product!.regularPrice ?? "0")} " +
                                    "sr".tr(),
                                fontsize: 16.fs,
                                color: AppColors.primiry,
                                weight: FontWeight.bold)
                            : Row(
                                children: [
                                  CustomText(
                                      "${double.tryParse(widget.product!.regularPrice ?? "0")} " +
                                          "sr".tr(),
                                      fontsize: 13.fs,
                                      color: AppColors.primiry,
                                      decoration: TextDecoration.lineThrough),
                                  SizedBox(width: 3.w),
                                  CustomText(
                                      "${double.tryParse(widget.product!.salePrice ?? "0")} " +
                                          "sr".tr(),
                                      fontsize: 16.fs,
                                      color: AppColors.primiry,
                                      weight: FontWeight.bold),
                                  //Spacer(),
                                ],
                              ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          child: CustomText("Details",
                              fontsize: 20.fs, weight: FontWeight.w600),
                        ),
                        HtmlWidget(
                            widget.product!.description == ''
                                ? 'No Details For This Item'
                                : widget.product!.description ?? "",
                            textStyle: TextStyle(fontSize: 15.fs),
                            onTapUrl: (s) {
                          launchUrl(Uri.parse(s),
                              mode: LaunchMode.externalApplication);
                          return true;
                        }),
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomText(
                              'relatedprod'.tr(),
                              fontsize: 20.fs,
                            ),
                          ),
                        ),
                        Builder(builder: (
                          context,
                        ) {
                          if ((widget.product!.relatedIds?.isEmpty) ?? true) {
                            return ProductsLoadnigItem();
                          } else {
                            return LoadingAndError(
                              isError:
                                  state is ProductScreenPageGetAdsErrorState,
                              isLoading:
                                  state is ProductScreenPageGetAdsLoadingState,
                              child: GridView.builder(
                                  shrinkWrap: true,
                                  primary: false,
                                  gridDelegate:
                                      SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent: 250,
                                          childAspectRatio: 0.859,
                                          mainAxisExtent: 200),
                                  itemBuilder: (BuildContext ctx, index) {
                                    return ProductWidget(
                                      products: related[index],
                                    );
                                  },
                                  itemCount: related.length),
                            );
                          }
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
