import 'package:flutter/material.dart';

Widget buildListProduct(shopProvider, model, context,
    {bool isFavorites = true}) {
  if (shopProvider.favorites[model.id] != null) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 120,
          width: double.infinity,
          child: Row(children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Container(
                  color: Colors.white,
                  child: Image(
                    image: NetworkImage(model.image),
                    width: 120.0,
                    height: 120.0,
                  ),
                ),
                if (model.discount != 0 && isFavorites)
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
            const SizedBox(width: 20.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    model.name,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.black, fontSize: 20.0),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      children: [
                        Text(
                          model.price.toString(),
                          style: const TextStyle(
                              fontSize: 15.0, color: Colors.redAccent),
                        ),
                        const SizedBox(width: 5.0),
                        if (model.discount != 0 && isFavorites)
                          Text(
                            model.oldPrice.toString(),
                            style: const TextStyle(
                                fontSize: 12.0,
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
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  } else {
    return const Center(child: CircularProgressIndicator());
  }
}
