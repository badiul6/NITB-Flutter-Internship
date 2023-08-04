import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/app/data/models/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  var pageCount = 0.obs;
  int _id = 0;
  int get id => _id;

  Rx<TextEditingController> titleController = TextEditingController().obs;
  Rx<TextEditingController> descriptionController = TextEditingController().obs;

  RxString response = "".obs;
  RxBool isError = false.obs;
  RxBool isLoading = false.obs;
  FirebaseFirestore db = FirebaseFirestore.instance;
  RxList<Product> products = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
    _getProducts();
  }

  setId(int id) {
    _id = id;
  }

  void addProduct(String name, String description) {
    isLoading.value = true;
    print("on add function");
    String id = DateTime.now().millisecondsSinceEpoch.toString();

    Product p = Product(name: name, description: description, id: id);

    db.collection('products').doc(id).set(p.toFirestore()).then((value) {
      isLoading.value = false;
      response.value = "Product Added Succesfully";
    }).onError((error, stackTrace) {
      isError.value = true;
      isLoading.value = false;
      response.value = error.toString();
    });
    titleController.value.clear();
    descriptionController.value.clear();
  }

  void _getProducts() {
    db.collection('products').snapshots().listen(
      (event) {
        products.assignAll(
          event.docs.map((doc) => Product.fromFirestore(doc)).toList(),
        );
      },
      onError: (error) => print("Listen failed: $error"),
    );
  }

  void updateProduct(String name, String description) {
    isLoading.value = true;

    final ref = db.collection("products").doc(_id.toString());
    ref.update({"name": name, "description": description}).then((value) {
      isLoading.value = false;
      response.value = "Product updated Succesfully";
    }, onError: (e) {
      isError.value = true;
      isLoading.value = false;
      response.value = e.toString();
    });
    titleController.value.clear();
    descriptionController.value.clear();
  }

  void deleteProduct() {
    db.collection("products").doc(_id.toString()).delete().then(
          (doc) => print("Document deleted"),
          onError: (e) => print("Error updating document $e"),
        );
  }
}
