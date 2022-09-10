import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:material_color_gen/material_color_gen.dart';
import 'firebase_options.dart';
import 'core/themes/colors.dart';
import 'core/utils/app_info.dart';
import 'core/utils/firebase_message.dart';
import 'data/sources/api/dio.dart';
import 'data/sources/hive/local_hive.dart';
import 'data/sources/local/sharedpreferences.dart';
import 'presentation/layout/cubit/layout_cubit.dart';
import 'presentation/screens/auth/cubit/cubit.dart';
import 'presentation/screens/cart/cubit/cubit.dart';
import 'presentation/screens/categories/cubit/cubit.dart';
import 'presentation/screens/checkout/cubit/cubit.dart';
import 'presentation/screens/favourite/cubit/cubit.dart';
import 'presentation/screens/home/cubit/cubit.dart';
import 'presentation/screens/orders/cubit/cubit.dart';
import 'presentation/screens/product_screen/cubit/cubit.dart';
import 'presentation/screens/profile/cubit/cubit.dart';
import 'presentation/screens/shop/cubit/cubit.dart';
import 'presentation/screens/splash/cubit/cubit.dart';
import 'presentation/screens/splash/splash.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(
      FBMessging.firebaseMessagingBackgroundHandler);
  CacheHelper.init();
  HiveLocal.init();
  DioHelper.init();
  await AppInfo().init();
  await EasyLocalization.ensureInitialized();
  await Hive.initFlutter();

  runApp(EasyLocalization(
      startLocale: Locale('ar', 'EG'),
      supportedLocales: [
        Locale('ar', 'EG'),
        Locale('en', 'US'),
      ],
      saveLocale: true,
      path: 'assets/translations',
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final botToastBuilder = BotToastInit();
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeLayoutCubit>(
          create: (context) => HomeLayoutCubit(),
        ),
        BlocProvider<HomePageCubit>(
          create: (context) => HomePageCubit(),
        ),
        BlocProvider<CategoriesCubit>(
          create: (context) => CategoriesCubit(),
        ),
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(),
        ),
        BlocProvider<FavouriteCubit>(
          create: (context) => FavouriteCubit(),
        ),
        BlocProvider<SplashCubit>(
          create: (context) => SplashCubit(),
        ),
        BlocProvider<ShopCubit>(
          create: (context) => ShopCubit(),
        ),
        BlocProvider<ProductScreenCubit>(
          create: (context) => ProductScreenCubit(),
        ),
        BlocProvider<CartCubit>(
          create: (context) => CartCubit(),
        ),
        BlocProvider<CheckOutCubit>(
          create: (context) => CheckOutCubit(),
        ),
        BlocProvider<OrdersCubit>(
          create: (context) => OrdersCubit(),
        ),
        BlocProvider<ProfileCubit>(
          create: (context) => ProfileCubit(),
        ),
      ],
      child: MaterialApp(
        navigatorObservers: [BotToastNavigatorObserver()],
        theme: ThemeData(
            fontFamily: "cairo",
            appBarTheme: AppBarTheme(
                iconTheme: IconThemeData(color: Colors.white),
                elevation: 0,
                titleTextStyle: TextStyle(color: Colors.white)),
            primarySwatch: AppColors.primiry.toMaterialColor(),
            scaffoldBackgroundColor:
                AppColors.lightGreybackgound.toMaterialColor()),
        navigatorKey: navigatorKey,
        builder: (_, child) {
          child = botToastBuilder(context, child);
          return child;
        },
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        title: "AlteraTech",
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String title = 'ggg';

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
