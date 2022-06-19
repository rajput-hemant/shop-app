import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shop_app/providers/products.dart';

import '../widgets/products_grid.dart';

enum FilterOption {
  Favourites,
  All,
}

class ProductOverviewScreen extends StatefulWidget {
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
        title: Text('MyShop'),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            onSelected: (FilterOption selectedValue) {
              setState(() {
                if (selectedValue == FilterOption.Favourites)
                  // productData.showFavoutiteOnly();
                  showFavoutiteOnly = true;
                else
                  // productData.showAll();
                  showFavoutiteOnly = false;
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favourites'),
                value: FilterOption.Favourites,
              ),
              PopupMenuItem(
                child: Text("Show All"),
                value: FilterOption.All,
              )
            ],
          )
        ],
      ),
      body: ProductsGrid(showFavoutite: showFavoutiteOnly),
    );
  }
}
