import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_lampa/core/utils/responsive.dart';
import 'package:new_lampa/presentation/componants/customtext.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/themes/colors.dart';
import '../../componants/loadinganderror.dart';
import '../../shared/background.dart';
import '../../shared/categoryItem.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
import 'widget/loading_category.dart';
import 'widget/loading_subcategory.dart';
import 'widget/subcategory_widget.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories>
    with AutomaticKeepAliveClientMixin {
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = CategoriesCubit.get(context);
      cubit.getDataCategories(context: context);
      cubit.getDataSubCategories(context: context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return BlocConsumer<CategoriesCubit, CategoriesStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = CategoriesCubit.get(context);
          return LoadingAndError(
              isError: state is CategoriesPageGetAdsErrorState,
              isLoading: state is CategoriesPageGetAdsLoadingState,
              child: Scaffold(
                backgroundColor: AppColors.lightGreybackgound,
                appBar: AppBar(
                  backgroundColor: AppColors.primiry,
                  title: CustomText('category'.tr(),
                      color: AppColors.white, fontsize: 19),
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
                ),
                body: Row(
                  children: [
                    LoadingAndError(
                      isError: state is CategoriesPageGetAdsErrorState,
                      isLoading: state is CategoriesPageGetAdsLoadingState,
                      childLoading: LoadingCategory(),
                      childError: Center(
                        child: Text('There is an error'),
                      ),
                      child: Container(
                        color: Colors.grey.shade100,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 40),
                          child: Card(
                            elevation: 5,
                            child: Container(
                              color: Colors.grey.shade50,
                              height: double.infinity,
                              width: 120.w,
                              child: ListView.builder(
                                // controller: categoriesController,
                                itemCount: cubit.categories.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () async {
                                      cubit.selectedId =
                                          cubit.categories[index].id!;
                                      await cubit.getDataSubCategories(
                                        context: context,
                                      );
                                    },
                                    child: Center(
                                      child: Container(
                                        color: cubit.selectedId ==
                                                cubit.categories[index].id
                                            ? AppColors.primiry.withOpacity(0.3)
                                            : AppColors.white,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: CustomText(
                                                  cubit.categories[index].name!
                                                      .replaceAll("amp;", " "),
                                                  color: AppColors.primiry,
                                                  fontsize: 14,
                                                  weight: FontWeight.bold,
                                                  maxLines: 3,
                                                  align: TextAlign.center),
                                            ),
                                            SizedBox(
                                              width: double.infinity,
                                              child: Divider(
                                                color: Colors.black38,
                                                height: 0,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                // scrollDirection: Axis.horizontal,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        child: LoadingAndError(
                      isError: state is SubCategoriesPageGetAdsErrorState,
                      isLoading: state is SubCategoriesPageGetAdsLoadingState,
                      childError: Center(
                        child: Text('There is an error'),
                      ),
                      childLoading: LoadingSubCategory(),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                childAspectRatio: .9,
                                crossAxisSpacing: 2,
                                mainAxisSpacing: 8),
                        itemBuilder: (context, index) {
                          return SubCategory(
                            subCategory: cubit.subCategories[index],
                          );
                        },
                        itemCount: cubit.subCategories.length,
                      ),
                    ))
                  ],
                ),
              ));
        });
  }

  @override
  bool get wantKeepAlive => true;
}
