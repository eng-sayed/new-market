import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../core/themes/colors.dart';
import '../../../core/utils/utils.dart';
import '../../componants/customtext.dart';
import '../../componants/loadinganderror.dart';
import '../../shared/empty_widget.dart';
import '../../shared/needLogin.dart';
import '../orders/cubit/cubit.dart';
import '../orders/cubit/states.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
import 'widgets/favourit_item.dart';

class Favourite extends StatefulWidget {
  const Favourite({Key? key}) : super(key: key);

  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  @override
  void initState() {
    final cubit = FavouriteCubit.get(context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      cubit.getWishliste(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavouriteCubit, FavouriteStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = FavouriteCubit.get(context);
          return LoadingAndError(
            isError: state is FavouriteGetDataError,
            isLoading: state is FavouriteGetDataLoading,
            child: Scaffold(
              appBar: AppBar(
                  title: CustomText(
                "WhishList".tr(),
                color: AppColors.white,
                fontsize: 19,
              )),
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.whatsapp),
                onPressed: () {
                  Utiles().openwhatsapp(context);
                },
              ),
              body: cubit.wishListProducts.isEmpty
                  ? EmptyWidget()
                  : ListView.builder(
                      itemBuilder: (context, index) {
                        return CreateWhishListItem(
                            product: cubit.wishListProducts[index]);
                      },
                      itemCount: cubit.wishListProducts.length,
                    ),
            ),
          );
        });
  }
}
