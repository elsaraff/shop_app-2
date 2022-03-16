import 'package:flutter/material.dart';
import 'package:shop_app_api_provider/core/cache_helper.dart';
import 'package:shop_app_api_provider/core/dio_helper.dart';
import 'package:shop_app_api_provider/core/functions.dart';
import 'package:shop_app_api_provider/screens/shop_layout/shop_layout.dart';
import 'package:shop_app_api_provider/models/login_model.dart';
import 'package:shop_app_api_provider/network/end_points.dart';
import 'package:shop_app_api_provider/widgets/show_toast.dart';

class LoginProvider extends ChangeNotifier {
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    suffix =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    isPassword = !isPassword;
    notifyListeners();
  }

  ShopLoginModel? loginModel;

  void userLogin({
    required BuildContext context,
    required String email,
    required String password,
  }) {
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      loginModel = ShopLoginModel.fromJson(value.data);
      notifyListeners();
      if (loginModel!.status == true) {
        showToast(
            text: loginModel!.message.toString(), state: ToastStates.SUCCESS);
        CacheHelper.saveData(key: 'token', value: loginModel!.data!.token)
            .then((value) {
          token = loginModel!.data!.token.toString();
          navigateAndFinish(context, const ShopLayout());
        });

        debugPrint(loginModel!.data!.token.toString());
      } else //login status = false
      {
        showToast(
            text: loginModel!.message.toString(), state: ToastStates.ERROR);
        debugPrint(loginModel!.message.toString());
      }
    }).catchError((error) {
      debugPrint(error.toString());
      showToast(text: loginModel!.message.toString(), state: ToastStates.ERROR);
      notifyListeners();
    });
  }
}
