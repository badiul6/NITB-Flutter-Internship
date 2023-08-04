import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String id;
  String name;
  String description;
  Product({required this.name, required this.description, required this.id});
  
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'description': description,
      'id': id
    };
  }
  factory Product.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot
  ) {
    final data = snapshot.data();
    return Product(
      name: data?['name'],
      description: data?['description'], 
      id: data?['id']
    );
  }
}
