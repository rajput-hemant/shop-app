class Product {
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
}
