import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_lampa/core/themes/colors.dart';
import 'package:new_lampa/core/utils/responsive.dart';
import 'package:new_lampa/presentation/componants/customtext.dart';
import 'package:new_lampa/presentation/screens/shop/cubit/cubit.dart';
import 'package:new_lampa/presentation/screens/shop/cubit/states.dart';

import '../../shared/navigator.dart';
import '../product_screen/product_screen.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key, required this.onchange, required this.oldSearch})
      : super(key: key);
  Function(SearchModel model) onchange;
  SearchModel oldSearch;
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  RangeValues? rangeValues;

  Sortstate sortstate = Sortstate.recent;

  String? searchtext;
  late TextEditingController textEditingController;
  FocusNode node = FocusNode();

  @override
  void initState() {
    node.requestFocus();
    textEditingController =
        TextEditingController(text: widget.oldSearch.searchtext);
    searchtext = widget.oldSearch.searchtext ?? "";
    rangeValues = widget.oldSearch.rangeValues ?? RangeValues(0, 10000);
    sortstate = widget.oldSearch.sortstate ?? Sortstate.recent;
    ShopCubit.get(context).searchSuggestions.clear();
    // Provider.of<MainScreenController>(context, listen: false)
    //     .searchSuggestions = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final value = ShopCubit.get(context);
    return Drawer(
      child: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
                child: SizedBox(
                  height: 36,
                  child: TextField(
                    onSubmitted: (s) {
                      widget.onchange(SearchModel(
                          rangeValues: rangeValues ?? RangeValues(0, 10000),
                          searchtext: searchtext,
                          sortstate: sortstate));
                    },
                    focusNode: node,
                    controller: textEditingController,
                    onChanged: (s) {
                      searchtext = s;

                      value.getSuggesstions(context, s);
                      if (s.isEmpty) {}
                    },
                    style: TextStyle(color: AppColors.primiry),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Search",
                        contentPadding: EdgeInsets.all(5),
                        prefixIcon: GestureDetector(
                          onTap: () {
                            widget.onchange(SearchModel(
                                rangeValues:
                                    rangeValues ?? RangeValues(0, 10000),
                                searchtext: searchtext,
                                sortstate: sortstate));
                          },
                          child: Card(
                              color: AppColors.primiry,
                              child: Icon(Icons.search, color: Colors.white)),
                        )),
                  ),
                ),
              ),
              BlocConsumer<ShopCubit, ShopStates>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    return (value.searchSuggestions.isNotEmpty)
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Card(
                              child: Container(
                                  child: Column(
                                children: value.searchSuggestions.map((e) {
                                  final index =
                                      value.searchSuggestions.indexOf(e);
                                  return ListTile(
                                    onTap: () {
                                      //TODO navigate(
                                      //     context: context,
                                      //     route: ProductScreen(
                                      //       product: e,
                                      //     ));
                                    },
                                    // tileColor: index.isEven
                                    //     ? AppColors.primiry.withOpacity(0.5)
                                    //     : Colors.transparent,
                                    title: CustomText(e.postTitle ?? "",
                                        weight: FontWeight.bold,
                                        color: Colors.white),
                                  );
                                }).toList(),
                              )),
                              color: AppColors.primiry.withOpacity(0.7),
                            ),
                          )
                        : SizedBox();
                  }),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: PriceSlider(
              //     initValuse: rangeValues ?? RangeValues(0, 10000),
              //     onChange: (s) {
              //       rangeValues = s;
              //     },
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(20.0),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     mainAxisSize: MainAxisSize.min,
              //     children: [
              //       CustomText("sortby".tr(),
              //           fontsize: 17.fs,
              //           weight: FontWeight.bold,
              //           color: Theme.of(context).primaryColor),
              //       InkWell(
              //         onTap: () {
              //           sortstate = Sortstate.recent;
              //           setState(() {});
              //         },
              //         child: SortingItem(
              //           firstStat: Sortstate.recent,
              //           sortstate: sortstate,
              //           title: "recent".tr(),
              //         ),
              //       ),
              //       SizedBox(
              //         height: 5,
              //       ),
              //       InkWell(
              //         onTap: () {
              //           sortstate = Sortstate.priceHTM;
              //           setState(() {});
              //         },
              //         child: SortingItem(
              //           firstStat: Sortstate.priceHTM,
              //           sortstate: sortstate,
              //           title: "htm".tr(),
              //         ),
              //       ),
              //       SizedBox(
              //         height: 5,
              //       ),
              //       InkWell(
              //         onTap: () {
              //           sortstate = Sortstate.priceMTH;
              //           setState(() {});
              //         },
              //         child: SortingItem(
              //           firstStat: Sortstate.priceMTH,
              //           sortstate: sortstate,
              //           title: "mth".tr(),
              //         ),
              //       )
              //     ],
              //   ),
              // ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    widget.onchange(SearchModel(
                        rangeValues: rangeValues ?? RangeValues(0, 10000),
                        searchtext: searchtext,
                        sortstate: sortstate));
                  },
                  child: CustomText("search".tr(), color: Colors.white))
            ],
          ),
        ),
      ),
    );
  }
}

class SearchModel {
  RangeValues? rangeValues;
  Sortstate? sortstate;
  String? searchtext;
  SearchModel({
    this.rangeValues,
    this.sortstate,
    this.searchtext,
  });
}

enum Sortstate { recent, priceHTM, priceMTH }

Sortstate? searchSortstate;

class SortingItem extends StatelessWidget {
  SortingItem(
      {Key? key,
      required this.title,
      required this.sortstate,
      required this.firstStat})
      : super(key: key);
  String title;
  Sortstate sortstate;
  Sortstate firstStat;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CustomText(title, fontsize: 15.fs, color: AppColors.primiry),
        Spacer(),
        Icon(
          sortstate == firstStat
              ? Icons.radio_button_on
              : Icons.radio_button_off,
          color: AppColors.primiry,
          size: 15,
        ),
      ],
    );
  }
}

class PriceSlider extends StatefulWidget {
  PriceSlider({
    Key? key,
    required this.onChange,
    required this.initValuse,
  }) : super(key: key);
  Function(RangeValues)? onChange;
  RangeValues initValuse;
  @override
  State<PriceSlider> createState() => _PriceSliderState();
}

class _PriceSliderState extends State<PriceSlider> {
  // RangeValues values = RangeValues(10, 1000);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CustomText("price".tr(),
                weight: FontWeight.bold,
                fontsize: 16.fs,
                color: AppColors.primiry),
            Row(
              children: [
                CustomText("${("sr").tr()} ${widget.initValuse.start.toInt()}",
                    fontsize: 14.fs, color: AppColors.primiry),
                Spacer(),
                CustomText("${("sr").tr()} ${widget.initValuse.end.toInt()}",
                    fontsize: 14.fs, color: AppColors.primiry),
              ],
            ),
            RangeSlider(
                values: widget.initValuse,
                min: 0,
                max: 10000,
                onChanged: (s) {
                  widget.onChange!(s);
                  widget.initValuse = s;
                  setState(() {});
                })
          ],
        ),
      ),
    );
  }
}
