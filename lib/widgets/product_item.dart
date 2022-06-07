import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String id, title, imageURL;

  const ProductItem({
    super.key,
    required this.id,
    required this.title,
    required this.imageURL,
  });

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Image.network(
        imageURL,
        fit: BoxFit.cover,
      ),
      footer: GridTileBar(
        backgroundColor: Colors.black54,
        leading: IconButton(
          icon: Icon(Icons.favorite),
          onPressed: () {},
        ),
        title: Text(
          title,
          textAlign: TextAlign.center,
        ),
        trailing: IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () {},
        ),
      ),
    );
  }
}
