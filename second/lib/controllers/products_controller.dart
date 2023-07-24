import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:get/get.dart';
import 'package:second/models/product.dart';

class ProductController extends GetxController {
  Rx<Product> product = Product().obs;
  var isLoading = true.obs;
  @override
  onInit() {
    super.onInit();

    fetchProducts();
  }

  fetchProducts() async {
    final response =
        await http.get(Uri.parse('https://dummyjson.com/products'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      product.value = Product.fromJson(data);
      isLoading.value = false;
    } else {
      throw Exception('Failed to load album');
    }
  }

  addNewProduct(
      {required File pic,
      required String title,
      required String description,
      required String price,
      required String rating}) {
    product.value.addProduct(
        pic: pic,
        title: title,
        description: description,
        price: price,
        rating: rating);
        product.refresh();
  }
     

}
