import 'package:flutter/material.dart';

class AdapterListView extends StatelessWidget {
  const AdapterListView({
    this.afterList = const [],
    this.beforeList = const [],
    required this.itemBuilder,
    required this.itemCount,
    required this.controller,
    Key? key,
  }) : super(key: key);
  final List<Widget> beforeList;
  final List<Widget> afterList;
  final ScrollController controller;
  final Widget? Function(BuildContext, int) itemBuilder;
  final int itemCount;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      controller: controller,
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: beforeList,
          ),
        ),
        SliverList(
            delegate:
                SliverChildBuilderDelegate(itemBuilder, childCount: itemCount)),
        SliverToBoxAdapter(
          child: Column(
            children: afterList,
          ),
        ),
      ],
    );
  }
}

class AdapterGridView extends StatelessWidget {
  const AdapterGridView({
    this.afterList = const [],
    this.beforeList = const [],
    required this.itemBuilder,
    required this.itemCount,
    this.loadingCondition,
    this.loadingWidget,
    this.controller,
    Key? key,
  }) : super(key: key);
  final List<Widget> beforeList;
  final List<Widget> afterList;
  final ScrollController? controller;
  final Widget? Function(BuildContext, int) itemBuilder;
  final int itemCount;
  final Widget? loadingWidget;
  final bool? loadingCondition;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      controller: controller,
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: beforeList,
          ),
        ),
        loadingCondition ?? false
            ? SliverToBoxAdapter(child: loadingWidget)
            : SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.859,
                    mainAxisExtent: 200),
                delegate: SliverChildBuilderDelegate(itemBuilder,
                    childCount: itemCount)),
        SliverToBoxAdapter(
          child: Column(
            children: afterList,
          ),
        ),
      ],
    );
  }
}
