import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';
  const ProductDetailScreen({Key? key}) : super(key: key);
  // final String title;

  // const ProductDetailScreen(this.title);

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final loadedProduct =
        Provider.of<Products>(context, listen: false).findByID(productId);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                loadedProduct.imageURL,
                fit: BoxFit.fitWidth,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '₹ ${loadedProduct.price}',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                loadedProduct.description,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
