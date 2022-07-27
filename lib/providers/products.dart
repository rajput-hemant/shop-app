import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';
import 'product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageURL:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageURL:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageURL:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageURL:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  // var _showFavoutiteOnly = false;

  List<Product> get items {
    // if (_showFavoutiteOnly)
    //   return _items.where((product) => product.isFavourite).toList();
    return [..._items];
  }

  List<Product> get favouriteItem {
    return _items.where((product) => product.isFavourite).toList();
  }

  String? _authToken;

  static const endpoint = 'https://shop-app-z-default-rtdb.firebaseio.com';

  set token(String token) => _authToken = token;

  Future<void> fetchProducts() async {
    final url = Uri.parse('$endpoint/products.json?auth=$_authToken');
    try {
      final response = await http.get(url);
      log(json.decode(response.body).toString());
      final extractedData = json.decode(response.body) as Map<String, dynamic>?;
      if (extractedData == null) return;
      final List<Product> loadedProducts = [];
      extractedData.forEach((id, data) {
        loadedProducts.add(
          Product(
            id: id,
            title: data['title'],
            price: data['price'],
            imageURL: data['imageURL'],
            isFavourite: data['isFavourite'],
            description: data['description'],
          ),
        );
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<void> addProduct(Product product) async {
    final url = Uri.parse('$endpoint/products.json?auth=$_authToken');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'price': product.price,
          'imageURL': product.imageURL,
          'description': product.description,
          'isFavourite': product.isFavourite,
        }),
      );
      final newProduct = Product(
        id: json.decode(response.body)['name'],
        title: product.title,
        description: product.description,
        price: product.price,
        imageURL: product.imageURL,
      );
      _items.add(newProduct);
      // to add new Product to the beginning of the items list
      // _items.insert(0, newProduct);
      notifyListeners();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  // Future<void> addProduct(Product product) {
  //   final url =
  //       Uri.https('shop-app-z-default-rtdb.firebaseio.com', '/products.json');
  //   return http
  //       .post(
  //     url,
  //     body: json.encode({
  //       'title': product.title,
  //       'price': product.price,
  //       'imageURL': product.imageURL,
  //       'description': product.description,
  //       'isFavourite': product.isFavourite,
  //     }),
  //   )
  //       .then((response) {
  //     final newProduct = Product(
  //       id: json.decode(response.body)['name'],
  //       title: product.title,
  //       description: product.description,
  //       price: product.price,
  //       imageURL: product.imageURL,
  //     );
  //     _items.add(newProduct);
  //     // to add new Product to the beginning of the items list
  //     // _items.insert(0, newProduct);
  //     notifyListeners();
  //   }).catchError((e) {
  //     log(e);
  //     throw e;
  //   });
  // }

  Future<void> updateProduct(String id, Product product) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    final url = Uri.parse('$endpoint/products/$id.json?auth=$_authToken');
    await http.patch(
      url,
      body: json.encode({
        'title': product.title,
        'description': product.description,
        'price': product.price,
        'imageURL': product.imageURL,
      }),
    );
    _items[prodIndex] = product;
    notifyListeners();
  }

  Future<void> deleteProduct(String id) async {
    final url = Uri.parse('$endpoint/products/$id.json?auth=$_authToken');
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    Product? existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException(message: "Could not delete Product.");
    }
    existingProduct = null;
  }

  Product findByID(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  // void showFavoutiteOnly() {
  //   _showFavoutiteOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoutiteOnly = false;
  //   notifyListeners();
  // }
}
