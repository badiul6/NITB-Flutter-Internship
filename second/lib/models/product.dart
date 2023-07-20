// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';
import 'dart:io';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
    List<ProductElement>? products;
    int? total;
    int? skip;
    int? limit;

    Product({
          this.products,
          this.total,
          this.skip,
          this.limit,
    });
addProduct({
  required File pic,
    required String title,
    required String description,
    required String price,
    required String rating
}){
    ProductElement newProduct = ProductElement(
  id: 1234,
  title: title,
  description: description,
  price: int.parse(price),
  discountPercentage: 10.0,
  rating: double.parse(rating),
  stock: 100,
  brand: 'Brand X',
  category: 'file',
  thumbnail: pic.toString(),
  images: [
    'https://example.com/image1.jpg',
    'https://example.com/image2.jpg',
  ],
);
    products!.add(newProduct);

  }
    factory Product.fromJson(Map<String, dynamic> json) => Product(
        products: List<ProductElement>.from(json["products"].map((x) => ProductElement.fromJson(x))),
        total: json["total"],
        skip: json["skip"],
        limit: json["limit"],
    );

    Map<String, dynamic> toJson() => {
        "products": List<dynamic>.from(products!.map((x) => x.toJson())),
        "total": total,
        "skip": skip,
        "limit": limit,
    };
}

class ProductElement {
    int? id;
    String? title;
    String? description;
    int? price;
    double? discountPercentage;
    double? rating;
    int? stock;
    String? brand;
    String? category;
    String? thumbnail;
    List<String>? images;

    ProductElement({
         this.id,
         this.title,
         this.description,
         this.price,
         this.discountPercentage,
         this.rating,
         this.stock,
         this.brand,
         this.category,
         this.thumbnail,
         this.images,
    });


    factory ProductElement.fromJson(Map<String, dynamic> json) => ProductElement(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        price: json["price"],
        discountPercentage: json["discountPercentage"]?.toDouble(),
        rating: json["rating"]?.toDouble(),
        stock: json["stock"],
        brand: json["brand"],
        category: json["category"],
        thumbnail: json["thumbnail"],
        images: List<String>.from(json["images"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "price": price,
        "discountPercentage": discountPercentage,
        "rating": rating,
        "stock": stock,
        "brand": brand,
        "category": category,
        "thumbnail": thumbnail,
        "images": List<dynamic>.from(images!.map((x) => x)),
    };
    @override
  String toString() {
    return 'ProductElement: {title: $title, description: $description, price: $price, rating: $rating}';
  }
}
