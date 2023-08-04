import 'package:get/get.dart';

import 'package:firebase_crud/app/modules/home/controllers/product_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductController>(()=>
      ProductController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
