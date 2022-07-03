import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
// import '../providers/products.dart';
import 'cart_screen.dart';
import '../widgets/badge.dart';
import '../widgets/products_grid.dart';

enum FilterOption {
  favourites,
  all,
}

class ProductOverviewScreen extends StatefulWidget {
  const ProductOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var showFavoutiteOnly = false;

  @override
  Widget build(BuildContext context) {
    // final productData = Provider.of<Products>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('MyShop'),
        centerTitle: true,
        actions: [
          Consumer<Cart>(
            builder: (_, cart, child) => Badge(
              value: cart.itemCount.toString(),
              child: child!,
            ),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () =>
                  Navigator.pushNamed(context, CartScreen.routeName),
            ),
          ),
          PopupMenuButton(
            onSelected: (FilterOption selectedValue) {
              setState(() {
                if (selectedValue == FilterOption.favourites) {
                  showFavoutiteOnly = true;
                } else {
                  showFavoutiteOnly = false;
                }
              });
            },
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: FilterOption.favourites,
                child: Text('Only favourites'),
              ),
              const PopupMenuItem(
                value: FilterOption.all,
                child: Text("Show all"),
              )
            ],
          )
        ],
      ),
      body: ProductsGrid(showFavoutite: showFavoutiteOnly),
    );
  }
}
