import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import 'edit_product_screen.dart';
import '../widgets/app_drawer.dart';
import '../widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';
  const UserProductsScreen({Key? key}) : super(key: key);

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false)
        .fetchProducts(filterByUser: true);
  }

  @override
  Widget build(BuildContext context) {
    // final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Products',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(child: CircularProgressIndicator())
                : RefreshIndicator(
                    onRefresh: () => _refreshProducts(context),
                    child: Consumer<Products>(
                      builder: (context, productsData, _) => Padding(
                        padding: const EdgeInsets.all(8),
                        child: productsData.items.isEmpty
                            ? const Center(
                                child: Text(
                                  "You have no products to manage,\n"
                                  "Start adding some.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            : ListView.builder(
                                itemCount: productsData.items.length,
                                itemBuilder: (_, i) => Column(
                                  children: [
                                    UserProductItem(
                                      id: productsData.items[i].id,
                                      title: productsData.items[i].title,
                                      imageURL: productsData.items[i].imageURL,
                                    ),
                                    const Divider(),
                                  ],
                                ),
                              ),
                      ),
                    ),
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () =>
            Navigator.pushNamed(context, EditProductScreen.routeName),
      ),
    );
  }
}
