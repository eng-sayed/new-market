import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingSubCategory extends StatelessWidget {
  const LoadingSubCategory({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: .9,
            crossAxisSpacing: 2,
            mainAxisSpacing: 8),
        itemBuilder: (_, __) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 48.0,
                height: 48.0,
                color: Colors.green,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.0),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 2.0),
              ),
              Container(
                width: 25,
                height: 8.0,
                color: Colors.green,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 2.0),
              ),
              Container(
                width: 25.0,
                height: 8.0,
                color: Colors.green,
              )
            ],
          ),
        ),
        itemCount: 10,
      ),
    );
  }
}
