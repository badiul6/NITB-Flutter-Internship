import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second/controllers/picture_controller.dart';
import 'package:second/controllers/products_controller.dart';

class AddProduct extends StatelessWidget {
  AddProduct({super.key});

  final PictureController pictureController = Get.put(PictureController());
  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(context) {
        TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    TextEditingController ratingController = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          title: const Text("Add a new Product"),
        ),
        body: Obx(() => SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 50),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          pictureController.getFromGallery();

                        },
                        child: pictureController.pic.value.imageFile == null
                            ? const CircleAvatar(
                                radius: 80,
                                backgroundColor:
                                    Color.fromARGB(255, 149, 149, 149),
                                child: Icon(
                                  Icons.photo_outlined,
                                  size: 130,
                                  color: Colors.white,
                                ))
                            : CircleAvatar(
                                radius: 80,
                                backgroundColor:
                                    const Color.fromARGB(255, 149, 149, 149),
                                foregroundImage: FileImage(
                                    pictureController.pic.value.imageFile!),
                              ),
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      TextFormField(
                        controller: titleController,
                        decoration: const InputDecoration(
                          
                            label: Text("Title"),
                            hintText: "Enter Product Name",
                            border: OutlineInputBorder()),
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      TextFormField(
                        controller: descriptionController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                            label: Text("Description"),
                            hintText: "Enter Product Detail",
                            border: OutlineInputBorder()),
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: priceController,
                              decoration: const InputDecoration(
                                label: Text("Price"),
                                hintText: "Enter price",
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const SizedBox(
                            width: 40.0,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: ratingController,
                              decoration: const InputDecoration(
                                  label: Text("Rating"),
                                  prefixIcon: Icon(Icons.remove),
                                  border: InputBorder.none,
                                  suffixIcon: Icon(Icons.add)),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50.0,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            productController.addNewProduct(pic: pictureController.pic.value.imageFile!, 
                            title: titleController.text, 
                            description: descriptionController.text, 
                            price: priceController.text, 
                            rating: ratingController.text);
                            Get.back();
                            // print(productController.product.value.products!.length.toString());
                            
                          },
                          style: ElevatedButton.styleFrom(
                              fixedSize: const Size(120, 55)),
                          child: const Text(
                            "Save",
                            style: TextStyle(fontSize: 20.0),
                          ))
                    ],
                  ),
                ),
              ),
            )));
  }
}
