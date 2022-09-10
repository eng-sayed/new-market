import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/utils/utils.dart';
import '../../../../data/sources/local/sharedpreferences.dart';
import 'states.dart';

class SplashCubit extends Cubit<SplashStates> {
  SplashCubit() : super(SplashInitial());
  static SplashCubit get(context) => BlocProvider.of(context);

  getToken() async {
    Utiles.token = await CacheHelper.loadData(key: "token") ?? "";
    Utiles.UserId = CacheHelper.loadData(key: "userid") ?? "";
    Utiles.wishListKey = CacheHelper.loadData(key: "share_key") ?? "";
    Utiles.Username = CacheHelper.loadData(key: "username") ?? "";
    print(Utiles.token);
  }

  // Widget navigateDirction() {
  //   Utiles.token = CacheHelper.loadData(key: "token") ?? "";
  //   print(Utiles.token);
  //   if (Utiles.token.isNotEmpty) {
  //     return " Routes.homeLayout";
  //   } else {
  //     return " Routes.loginScreen";
  //   }
  // }
}
