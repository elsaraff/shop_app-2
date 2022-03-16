import 'package:flutter/material.dart';
import 'package:shop_app_api_provider/core/dio_helper.dart';
import 'package:shop_app_api_provider/models/categories_model.dart';
import 'package:shop_app_api_provider/models/change_favorites_model.dart';
import 'package:shop_app_api_provider/models/favorites_model.dart';
import 'package:shop_app_api_provider/models/home_model.dart';
import 'package:shop_app_api_provider/models/login_model.dart';
import 'package:shop_app_api_provider/network/end_points.dart';
import 'package:shop_app_api_provider/screens/categories/categories_screen.dart';
import 'package:shop_app_api_provider/screens/favourites/favourites_screen.dart';
import 'package:shop_app_api_provider/screens/products/products_screen.dart';
import 'package:shop_app_api_provider/screens/settings/settings_screen.dart';
import 'package:shop_app_api_provider/widgets/show_toast.dart';

class ShopProvider with ChangeNotifier {
  int currentIndex = 0;

  void changeBottom(int index) {
    currentIndex = index;
    notifyListeners();
  }

  List<String> title = [
    'Home',
    'Categories',
    'Favorites',
    'Settings',
  ];

  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    const BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Categories'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.favorite), label: 'Favorites'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.settings), label: 'Settings'),
  ];

  List<Widget> bottomScreen = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavouritesScreen(),
    const SettingsScreen(),
  ];

  //_____________________________________________________

  HomeModel? homeModel;
  Map<int, bool> favorites = {};

  void getHomeData() {
    DioHelper.getData(
      url: HOME,
      token: token,
      lang: 'en',
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      for (var element in homeModel!.data!.products) {
        favorites.addAll({element.id!: element.inFavorites!});
      }
      notifyListeners();
    }).catchError((error) {
      debugPrint(error.toString());
      notifyListeners();
    });
  }

  //_____________________________________________________

  CategoriesModel? categoriesModel;

  void getCategories() {
    DioHelper.getData(
      url: GET_CATEGORIES,
      lang: 'en',
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      notifyListeners();
    }).catchError((error) {
      debugPrint(error.toString());
      notifyListeners();
    });
  }

  //_____________________________________________________
  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;
    notifyListeners();

    DioHelper.postData(
      url: FAVORITES,
      data: {'product_id': productId},
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      if (!changeFavoritesModel!.status!) {
        favorites[productId] = !favorites[
            productId]!; // if problem exist after change avatar color (Quickly)
      } else {
        getFavorites();
      }
      notifyListeners();
      showToast(
          text: changeFavoritesModel!.message.toString(),
          state: ToastStates.SUCCESS);
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;
      debugPrint(error.toString());
      showToast(
          text: changeFavoritesModel!.message.toString(),
          state: ToastStates.ERROR);
      notifyListeners();
    });
  }

  FavoritesModel? favoritesModel;

  void getFavorites() {
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      notifyListeners();
    }).catchError((error) {
      debugPrint(error.toString());
      notifyListeners();
    });
  }

  ShopLoginModel? userModel;
  void getUserData() {
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      notifyListeners();
    }).catchError((error) {
      debugPrint(error.toString());
      notifyListeners();
    });
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    notifyListeners();

    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      notifyListeners();
    }).catchError((error) {
      debugPrint(error.toString());
      notifyListeners();
    });
  }
}
