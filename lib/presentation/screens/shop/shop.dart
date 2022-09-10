import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../core/themes/colors.dart';
import '../../../core/utils/utils.dart';
import '../../../domain/models/product/wooproduct.dart';
import '../../componants/customtext.dart';
import '../filter/filter_and_search_screen.dart';
import 'cubit/cubit.dart';
import 'widgets/gridList.dart';
import 'widgets/listview.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen(
      {Key? key,
      required this.title,
      this.categoryId,
      this.onsale,
      this.showBack = true})
      : super(key: key);
  final String title;
  final int? categoryId;
  final bool? onsale;
  final bool showBack;
  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isList = false;
  bool _showBackToTopButton = false;
  void _scrollToTop() {
    scrollController.animateTo(0,
        duration: const Duration(microseconds: 1500), curve: Curves.linear);
  }

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          if (scrollController.offset >= 400) {
            _showBackToTopButton = true; // show the back-to-top button
          } else {
            _showBackToTopButton = false; // hide the back-to-top button
          }
        });
      });
    final cubit = ShopCubit.get(context);
    print("errer" + widget.categoryId.toString());
    cubit.pagingController = PagingController<int, WooProduct>(firstPageKey: 1);
    cubit.pagingController.addPageRequestListener((pageKey) async {
      await cubit.fetchPage(
        context,
        catId: widget.categoryId,
        onsale: widget.onsale,
        pageKey: pageKey,
      );
    }); // TODO: implement initState
    super.initState();
  }

  GlobalKey<ScaffoldState> scafoldkey = GlobalKey<ScaffoldState>();

  SearchModel searchModel = SearchModel();
  @override
  Widget build(BuildContext context) {
    final cubit = ShopCubit.get(context);
    return Scaffold(
      floatingActionButton: widget.title == "shop"
          ? _showBackToTopButton == false
              ? null
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 150, horizontal: 1),
                  child: FloatingActionButton(
                      child: Icon(Icons.arrow_upward), onPressed: _scrollToTop),
                )
          : FloatingActionButton(
              child: Icon(Icons.whatsapp),
              onPressed: () {
                Utiles().openwhatsapp(context);
              },
            ),
      key: scafoldkey,
      endDrawer: SearchScreen(
        oldSearch: cubit.searchModel,
        onchange: (s) {
          cubit.searchModel = s;
          print(s.searchtext);
          Navigator.pop(context);
          cubit.pagingController.refresh();
        },
      ),
      appBar: AppBar(
        leading: Navigator.of(context).canPop()
            ? IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            : null,
        title: CustomText(
          "${widget.title.replaceAll("amp;", "")}".tr(),
          color: AppColors.white,
          fontsize: 19,
        ),
        actions: [
          IconButton(
            onPressed: () {
              isList = !isList;
              setState(() {});
            },
            icon: Icon(Icons.list),
          ),
          IconButton(
            onPressed: () {
              scafoldkey.currentState!.openEndDrawer();
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: isList ? ListViewProducts() : GridViewProducts(),
    );
  }
}
