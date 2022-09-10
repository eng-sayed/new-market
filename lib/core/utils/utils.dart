import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/sources/local/sharedpreferences.dart';

class Utiles {
  static bool isLogin = true;
  static ThemeMode appMode = ThemeMode.light;
  static RegExp doubleNumRegEx = RegExp(r'(^\d*\.?\d*)');
  static RegExp intNumRegEx = RegExp(r'(^\d*)');
  static String token = "";
  static String UserId = "";
  static String Username = "";
  static String x_WC_Store = "";
  static String wishListKey = "";
  static String apiUrl = "https://alteratech.reeras.site";

  openwhatsapp(context) async {
    var whatsapp = "+201050609789";
    var whatsappURl_android = "whatsapp://send?phone=" + whatsapp + "&text= ";
    var whatappURL_ios = "https://wa.me/$whatsapp?text=${Uri.parse(" ")}";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunch(whatappURL_ios)) {
        await launch(whatappURL_ios, forceSafariVC: false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("whatsapp no installed".tr())));
      }
    } else {
      // android , web
      if (await canLaunch(whatsappURl_android)) {
        await launch(whatsappURl_android);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("whatsapp no installed".tr())));
      }
    }
  }

  static logout() {
    token = "";
    UserId = "";
    Username = "";
    x_WC_Store = "";
    wishListKey = "";
    CacheHelper.sharedPreferences.clear();
  }

  static removeToken() {
    token = "";
    CacheHelper.removeData(key: "token");
  }

  static getScrollFinal(
      ScrollController scrollController, VoidCallback onReachEnd) {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        print("object");
        onReachEnd();
      }
    });
  }

  static String trakingStatus(String status) {
    if (status == "on-hold") {
      return "onhold".tr();
    } else if (status == "processing") {
      return "processing".tr();
    } else if (status == "completed") {
      return "completed".tr();
    } else if (status == "failed") {
      return "failed".tr();
    } else if (status == "pendding_payment") {
      return "pendding_payment".tr();
    } else {
      return "canceled".tr();
    }
  }
}
