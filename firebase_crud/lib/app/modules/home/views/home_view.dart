import 'package:firebase_crud/app/modules/home/controllers/product_controller.dart';
import 'package:firebase_crud/app/modules/home/views/add_product_view.dart';
import 'package:firebase_crud/app/modules/home/views/edit_product_view.dart';
import 'package:firebase_crud/app/modules/home/views/products_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class HomeView extends GetView<ProductController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Obx(
      () => Scaffold(appBar: _appBar(controller), body: _buildBody(controller)

          // : const AddProductView(),
          ),
    ));
  }

  AppBar? _appBar(ProductController controller) {
    if (controller.pageCount.value == 0) {
      return null;
    } else if (controller.pageCount.value == 1) {
      return AppBar(
        leading: IconButton(
            onPressed: () {
              controller.pageCount.value = 0;
              controller.titleController.value.clear();
              controller.descriptionController.value.clear();
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text("Add Product"),
      );
    } else if (controller.pageCount.value == 2) {
      return AppBar(
        leading: IconButton(
            onPressed: () {
              controller.pageCount.value = 1;
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text("Products"),
      );
    } else if (controller.pageCount.value == 3) {
      return AppBar(
        leading: IconButton(
            onPressed: () {
              controller.pageCount.value = 2;
              controller.titleController.value.clear();
              controller.descriptionController.value.clear();
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text("Edit Product"),
      );
    }
    return null;
  }

  Widget? _buildBody(ProductController controller) {
    if (controller.pageCount.value == 0) {
      return Center(
        child: InkWell(
          onTap: () {
            controller.pageCount.value = 1;
          },
          child: Container(
            alignment: Alignment.center,
            height: 100,
            width: 200,
            decoration: BoxDecoration(
                gradient:
                    const LinearGradient(colors: [Colors.blue, Colors.red]),
                color: Colors.blue,
                borderRadius: BorderRadius.circular(50)),
            child: const Text(
              "Get Started",
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
        ),
      );
    } else if (controller.pageCount.value == 1) {
      return const AddProductView();
    } else if (controller.pageCount.value == 2) {
      return const ProductsView();
    } else if (controller.pageCount.value == 3) {
      return const EditProductView();
    } else {
      return null;
    }
  }
}
