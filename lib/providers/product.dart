import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id, title, description;
  final double price;
  final String imageURL;
  bool isFavourite;
  String? _authToken;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageURL,
    this.isFavourite = false,
  });

  static const endpoint = 'https://shop-app-z-default-rtdb.firebaseio.com';

  set token(String token) => _authToken = token;

  void _setFavValue(bool newValue) {
    isFavourite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavouriteStatus() async {
    final oldStatus = isFavourite;
    isFavourite = !isFavourite;
    notifyListeners();
    final url = Uri.parse('$endpoint/products/$id.json?auth=$_authToken');
    try {
      final response = await http.patch(
        url,
        body: json.encode({
          'isFavourite': isFavourite,
        }),
      );
      if (response.statusCode >= 400) _setFavValue(oldStatus);
    } catch (e) {
      _setFavValue(oldStatus);
    }
  }
}
