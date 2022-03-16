import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_api_provider/core/functions.dart';
import 'package:shop_app_api_provider/models/categories_model.dart';
import 'package:shop_app_api_provider/screens/shop_layout/shop_provider.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ShopProvider>(
      builder: (context, shopProvider, child) {
        if (shopProvider.categoriesModel != null) {
          return ListView.separated(
            itemBuilder: (context, index) =>
                buildCatItem(shopProvider.categoriesModel!.data!.data[index]),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: shopProvider.categoriesModel!.data!.data.length,
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

Widget buildCatItem(DataModel model) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Row(
        children: [
          Container(
            color: Colors.white,
            child: Image(
              image: NetworkImage(model.image!),
              width: 80,
              height: 80,
              // fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 20.0),
          Text(
            model.name!,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios_sharp)
        ],
      ),
    );
