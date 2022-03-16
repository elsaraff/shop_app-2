import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_api_provider/core/functions.dart';
import 'package:shop_app_api_provider/models/categories_model.dart';
import 'package:shop_app_api_provider/models/home_model.dart';
import 'package:shop_app_api_provider/screens/shop_layout/shop_provider.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ShopProvider>(
      builder: (context, shopProvider, child) {
        if (shopProvider.homeModel != null) {
          return buildProductBody(shopProvider, shopProvider.homeModel!,
              shopProvider.categoriesModel!);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

/*______________________________________________________________________*/
  Widget buildProductBody(
    shopProvider,
    HomeModel homeModel,
    CategoriesModel categoriesModel,
  ) =>
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildBannersCarousel(homeModel),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  myDivider(),
                  //____________________________________________________________
                  const Text(
                    'Categories',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 100,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => buildCategoryItem(
                            categoriesModel.data!.data[index]),
                        separatorBuilder: (context, index) => const SizedBox(
                              width: 5,
                            ),
                        itemCount: categoriesModel.data!.data.length),
                  ),
                  myDivider(),
                  //____________________________________________________________
                  const Text(
                    'New Products',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
            Container(
              color: Colors.grey,
              child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 2.0,
                  crossAxisSpacing: 2.0,
                  childAspectRatio: 1 / 1.65,
                  children: List.generate(
                      homeModel.data!.products.length,
                      (index) => buildGridProduct(
                          shopProvider, homeModel.data!.products[index]))),
            )
          ],
        ),
      );

  /*______________________________________________________________________*/

  Widget buildBannersCarousel(HomeModel model) => CarouselSlider(
      items: model.data!.banners
          .map((e) => Image(
                image: NetworkImage(e.image!),
                width: double.infinity,
                fit: BoxFit.cover,
              ))
          .toList(),
      options: CarouselOptions(
        height: 250.0,
        viewportFraction: 1.0, //0 to 1
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(seconds: 1),
        autoPlayCurve: Curves.fastOutSlowIn,
        scrollDirection: Axis.horizontal,
      ));

/*______________________________________________________________________*/

  Widget buildCategoryItem(DataModel model) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Container(
            color: Colors.white,
            child: Image(
              image: NetworkImage(model.image!),
              fit: BoxFit.cover,
              width: 100.0,
              height: 100.0,
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.7),
            width: 100.0,
            child: Text(model.name!,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 10, color: Colors.white)),
          )
        ],
      );

/*______________________________________________________________________*/

  Widget buildGridProduct(shopProvider, ProductModel model) => Container(
        color: Colors.white,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Container(
                color: Colors.white,
                child: Image(
                  image: NetworkImage(model.image!),
                  width: double.infinity,
                  height: 200.0,
                ),
              ),
              if (model.discount != 0)
                Container(
                  color: Colors.red,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'Discount',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: Colors.black, fontSize: 14.0, height: 1.3),
                ),
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    Text(
                      '${model.price} L.E',
                      style: const TextStyle(
                          fontSize: 13.0, color: Colors.redAccent),
                    ),
                    const SizedBox(width: 5.0),
                    if (model.discount != 0)
                      Text(
                        '${model.oldPrice} L.E',
                        style: const TextStyle(
                            fontSize: 11.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      ),
                    const Spacer(),
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: shopProvider.favorites[model.id]
                          ? Colors.red
                          : Colors.grey,
                      child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            shopProvider.changeFavorites(model.id);
                          },
                          icon: const Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                            size: 16.0,
                          )),
                    )
                  ],
                ),
              ],
            ),
          ),
        ]),
      );
}
