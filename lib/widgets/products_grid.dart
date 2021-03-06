import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import 'product_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavoutite;

  const ProductsGrid({super.key, required this.showFavoutite});
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products =
        showFavoutite ? productsData.favouriteItem : productsData.items;
    return products.isEmpty
        ? const Center(
            child: Text(
              "You have no Products in your Shop.\n"
              "Start adding some.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        : GridView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: products.length,
            itemBuilder: (context, index) => ChangeNotifierProvider.value(
              value: products[index],
              // create: (context) => products[index],
              child: const ProductItem(
                  // id: products[index].id,
                  // title: products[index].title,
                  // imageURL: products[index].imageURL,
                  ),
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
          );
  }
}
