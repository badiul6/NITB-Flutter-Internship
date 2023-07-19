import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second/controllers/picture_controller.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  PictureController pictureController = Get.put(PictureController());

  @override
  Widget build(context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add a new Product"),
        ),
        body: Obx(() => SingleChildScrollView(
          child: Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15.0, vertical: 50),
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
                        decoration: const InputDecoration(
                            label: Text("Title"),
                            hintText: "Enter Product Name",
                            border: OutlineInputBorder()),
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      TextFormField(
                        maxLines: 3,
                        decoration: const InputDecoration(
                            label: Text("Description"),
                            hintText: "Enter Product Detail",
                            border: OutlineInputBorder()),
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                label: Text("Price"),
                                hintText: "Enter price",
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 40.0,
                          ),
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  label: Text("Rating"),
                                  prefixIcon: Icon(Icons.remove),
                                  border: InputBorder.none,
                                  suffixIcon: Icon(Icons.add)),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      ElevatedButton(onPressed: () {},style: ElevatedButton.styleFrom(
                        fixedSize: const Size(120, 55)
                      ), child: const Text("Save", style: TextStyle(fontSize: 20.0),))
                    ],
                  ),
                ),
              ),
        )));
  }
}
