import 'package:firebase_crud/app/components/custom_sized_box.dart';
import 'package:firebase_crud/app/modules/home/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:get/get.dart';

class ProductsView extends GetView<ProductController> {
  const ProductsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.products.length,
        itemBuilder: (context, index) => Center(
              child: Container(
                width: 330,
                height: 500,
                padding: const EdgeInsets.all(10.0),
                child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color:
                        Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                            .withOpacity(0.1),
                    elevation: 02,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top: 10),
                            height: 200,
                            width: double.infinity,
                            child: Image.network(
                              "https://images.pexels.com/photos/3907507/pexels-photo-3907507.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                              fit: BoxFit.contain,
                            ),
                          ),
                          CustomSizedBox(
                            height: 40,
                          ),
                          Text(
                            controller.products.value[index].name,
                            style: const TextStyle(fontSize: 26),
                          ),
                          CustomSizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Description",
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(controller.products.value[index].description),
                          Row(
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    controller.titleController.value.text =
                                        controller.products.value[index].name;
                                    controller
                                            .descriptionController.value.text =
                                        controller
                                            .products.value[index].description;
                                    controller.setId(int.parse(
                                        controller.products.value[index].id));
                                    controller.pageCount.value = 3;
                                  },
                                  child: const Text(
                                    "Edit",
                                    style: TextStyle(color: Colors.white),
                                  )),
                              CustomSizedBox(
                                width: 20,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    controller.setId(int.parse(
                                        controller.products.value[index].id));
                                    controller.deleteProduct();
                                  },
                                  child: const Text("Delete",
                                      style: TextStyle(color: Colors.white)))
                            ],
                          )
                        ],
                      ),
                    )),
              ),
            )));
  }
}
