import 'package:flutter/widgets.dart';

class CartItem {
  final String id, title;
  final int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem>? _items;

  Map<String, CartItem> get items {
    return {..._items!};
  }

  void addItems(String productId, String title, double price) {
    if (_items!.containsKey(productId)) {
      _items!.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          quantity: existingCartItem.quantity + 1,
          price: existingCartItem.price,
        ),
      );
    } else {
      _items!.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          quantity: 1,
          price: price,
        ),
      );
    }
  }
}
