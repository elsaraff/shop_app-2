import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_api_provider/core/functions.dart';
import 'package:shop_app_api_provider/screens/shop_layout/shop_provider.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ShopProvider>(
      builder: (context, shopProvider, child) {
        return Scaffold(
          appBar: AppBar(
              title: Text(shopProvider.title[shopProvider.currentIndex]),
              actions: [
                IconButton(
                    onPressed: () {
                      signOut(context);
                    },
                    icon: const Icon(Icons.logout)),
              ]),
          body: shopProvider.bottomScreen[shopProvider.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            elevation: 25.0,
            items: shopProvider.bottomItems,
            currentIndex: shopProvider.currentIndex,
            onTap: (index) => shopProvider.changeBottom(index),
          ),
        );
      },
    );
  }
}
