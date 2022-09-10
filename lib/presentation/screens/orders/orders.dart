import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_lampa/core/themes/colors.dart';
import 'package:new_lampa/core/utils/utils.dart';
import 'package:new_lampa/presentation/componants/customtext.dart';
import 'package:new_lampa/presentation/componants/loadinganderror.dart';
import 'package:new_lampa/presentation/screens/orders/cubit/cubit.dart';
import 'package:new_lampa/presentation/screens/orders/cubit/states.dart';
import 'package:new_lampa/presentation/shared/needLogin.dart';
import 'package:new_lampa/presentation/shared/order_item.dart';

class OrdersScreen extends StatefulWidget {
  OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (Utiles.token.isNotEmpty) {
        final cubit = OrdersCubit.get(context);
        cubit.getOrders(context);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NeedLogin(
      child: BlocConsumer<OrdersCubit, OrdersStates>(
          listener: (context, state) {},
          builder: (context, state) {
            final cubit = OrdersCubit.get(context);
            return LoadingAndError(
              isError: state is OrdersGetDataError,
              isLoading: state is OrdersGetDataLoading,
              child: Scaffold(
                appBar: AppBar(
                  title: CustomText(
                    'Orders'.tr(),
                    textStyleEnum: TextStyleEnum.title,
                    color: AppColors.white,
                  ),
                ),
                body: ListView.builder(
                  itemBuilder: (context, index) {
                    return OrderItemWidget(
                        order: cubit.orders[index], showTrack: true);
                  },
                  itemCount: cubit.orders.length,
                ),
              ),
            );
          }),
    );
  }
}
