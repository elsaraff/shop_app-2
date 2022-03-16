import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_api_provider/core/cache_helper.dart';
import 'package:shop_app_api_provider/core/dio_helper.dart';
import 'package:shop_app_api_provider/network/end_points.dart';
import 'package:shop_app_api_provider/screens/login/login_screen.dart';
import 'package:shop_app_api_provider/screens/on_boarding/on_boarding_screen.dart';
import 'package:shop_app_api_provider/screens/shop_layout/shop_layout.dart';
import 'package:shop_app_api_provider/screens/shop_layout/shop_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();
  DioHelper.init();

  bool onBoarding = CacheHelper.getBoolean(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');

  debugPrint(onBoarding.toString());
  debugPrint(token.toString());

  Widget startWidget;

  if (onBoarding == false) {
    startWidget = const OnBoardingScreen();
  } else {
    if (token == '') {
      startWidget = const LoginScreen();
    } else {
      startWidget = const ShopLayout();
    }
  }

  runApp(MyApp(
    startWidget: startWidget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;

  const MyApp({Key? key, this.startWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ShopProvider()
        ..getHomeData()
        ..getCategories()
        ..getFavorites()
        ..getUserData(),
      child: MaterialApp(
        title: 'Shop App',
        theme: ThemeData(
          primarySwatch: Colors.red,
          fontFamily: 'saraff',
        ),
        debugShowCheckedModeBanner: false,
        home: startWidget,
      ),
    );
  }
}
