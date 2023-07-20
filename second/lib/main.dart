import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second/controllers/picture_controller.dart';
import 'package:second/controllers/products_controller.dart';
import 'package:second/views/products_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      // initialBinding: BindingsBuilder(() {
      //   Get.lazyPut<ProductController>(() {
      //  return ProductController();
      // });
      // }) ,
       initialBinding: BindingsBuilder(() {
        Get.lazyPut<ProductController>(() => ProductController());
        Get.lazyPut<PictureController>(() => PictureController());

      }),
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home:  ProductsPage(),
    );
  }
}
