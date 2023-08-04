class Product {
  final List<String> title;
  final List<String> description;
  final List<int> price;
  final List<double> rating;
  final List<String> thumbnail;

  const Product(
      {required this.title,
      required this.description,
      required this.price,
      required this.rating,
      required this.thumbnail});

  factory Product.fromJson(Map<String, dynamic> json) {
    final List<dynamic> products = json['products'];
    final List<String> titles =
        products.map((product) => product['title'] as String).toList();
    final List<String> descriptions =
        products.map((product) => product['description'] as String).toList();
    final List<int> prices =
        products.map((product) => product['price'] as int).toList();
    final List<double> ratings = products
        .map((product) => (product['rating'] as num).toDouble())
        .toList();


    final List<String> thumbnails =
        products.map((product) => product['thumbnail'] as String).toList();

    return Product(
        title: titles,
        description: descriptions,
        price: prices,
        rating: ratings,
        thumbnail: thumbnails);
  }
}
