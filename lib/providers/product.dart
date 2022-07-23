import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id, title, description;
  final double price;
  final String imageURL;
  bool isFavourite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageURL,
    this.isFavourite = false,
  });

  void _setFavValue(bool newValue) {
    isFavourite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavouriteStatus() async {
    final oldStatus = isFavourite;
    isFavourite = !isFavourite;
    notifyListeners();
    final url = Uri.https(
        'shop-app-z-default-rtdb.firebaseio.com', '/products/$id.json');
    try {
      final response = await http.patch(
        url,
        body: 
        json.encode({
          'isFavourite': isFavourite,
        }),
      );
      if (response.statusCode >= 400) _setFavValue(oldStatus);
    } catch (e) {
      _setFavValue(oldStatus);
    }
  }
}
