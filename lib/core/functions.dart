import 'package:flutter/material.dart';
import 'package:shop_app_api_provider/core/cache_helper.dart';
import 'package:shop_app_api_provider/screens/login/login_screen.dart';
import 'package:shop_app_api_provider/widgets/show_toast.dart';

navigateTo(context, widget) {
  return Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => widget),
  );
}

navigateAndFinish(context, widget) {
  return Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => widget),
    (route) => false,
  );
}

void signOut(context) {
  CacheHelper.removeData(key: 'token').then((value) {
    if (value) {
      debugPrint(value.toString());
      navigateAndFinish(context, const LoginScreen());
      showToast(text: 'Logout done Successfully', state: ToastStates.WARNING);
    }
  }).catchError((error) {
    debugPrint(error.toString());
  });
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern
      .allMatches(text)
      .forEach((match) => debugPrint(match.group(0).toString()));
}

Widget myDivider() => Column(
      children: [
        const SizedBox(height: 5),
        Container(
          height: 2.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0), color: Colors.red),
        ),
      ],
    );
