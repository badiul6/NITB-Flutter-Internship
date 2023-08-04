import 'package:firebase_crud/app/components/custom_sized_box.dart';
import 'package:firebase_crud/app/components/custom_text_field.dart';
import 'package:firebase_crud/app/modules/home/controllers/product_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class AddProductView extends GetView<ProductController> {
  const AddProductView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(),
            CustomSizedBox(
              height: 35,
            ),
            CustomTextField(
                label: 'Product Name',
                controller: controller.titleController.value),
            CustomSizedBox(
              height: 20,
            ),
            CustomTextField(
                label: 'Description',
                maxlines: 4,
                controller: controller.descriptionController.value),
            CustomSizedBox(
              height: 40,
            ),
            ElevatedButton(
                onPressed: () {
                  controller.addProduct(controller.titleController.value.text,
                      controller.descriptionController.value.text);

                  showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => Obx(
                            () => controller.isLoading.isTrue
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : AlertDialog(
                                    title: controller.isError.isTrue
                                        ? const Icon(
                                            Icons.error_outline,
                                            color: Colors.red,
                                          )
                                        : const Icon(
                                            Icons.check_circle_outlined,
                                            color: Colors.green,
                                          ),
                                    content: Text(
                                        controller.response.value.toString()),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          controller.isError.value = false;

                                          Navigator.pop(context, 'OK');
                                          controller.pageCount.value = 2;
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ),
                          ));
                },
                style: ElevatedButton.styleFrom(fixedSize: const Size(100, 45)),
                child: const Text("Save"))
          ],
        ),
      ),
    );
  }
}
