import 'package:flutter/material.dart';
import 'package:shop_app_api_provider/core/cache_helper.dart';
import 'package:shop_app_api_provider/core/dio_helper.dart';
import 'package:shop_app_api_provider/core/functions.dart';
import 'package:shop_app_api_provider/models/login_model.dart';
import 'package:shop_app_api_provider/network/end_points.dart';
import 'package:shop_app_api_provider/screens/shop_layout/shop_layout.dart';
import 'package:shop_app_api_provider/widgets/show_toast.dart';

class RegisterProvider extends ChangeNotifier {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    notifyListeners();
  }

  //===================================================================================

  ShopLoginModel? loginModel;

  void userRegister({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    DioHelper.postData(
      url: REGISTER,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
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
          nameController.clear();
          emailController.clear();
          phoneController.clear();
          passwordController.clear();
        });
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
