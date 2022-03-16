import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_api_provider/core/functions.dart';
import 'package:shop_app_api_provider/screens/shop_layout/shop_provider.dart';
import 'package:shop_app_api_provider/widgets/build_item.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ShopProvider>(
      builder: (context, shopProvider, child) {
        if (shopProvider.favoritesModel != null) {
          if (shopProvider.favoritesModel!.data!.data!.isEmpty) {
            return const Center(
                child: Text('You Don\'t have any favorites items.'));
          } else {
            return ListView.separated(
                itemBuilder: (context, index) => buildListProduct(
                    shopProvider,
                    shopProvider.favoritesModel!.data!.data![index].product,
                    context),
                separatorBuilder: (context, index) => myDivider(),
                itemCount: shopProvider.favoritesModel!.data!.data!.length);
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
