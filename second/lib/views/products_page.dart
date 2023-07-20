import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second/controllers/products_controller.dart';
import 'package:second/views/add_product_page.dart';
import 'package:second/views/singleproduct.dart';

class ProductsPage extends StatelessWidget {
  ProductsPage({super.key});

  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(
            " Products: ${productController.product.value.products == null ? 0 : productController.product.value.products!.length}")),
      ),
      body: Obx(() => productController.isLoading.isTrue
          ? const Center(child: CircularProgressIndicator())
          : ListView.separated(
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Get.to(() => SingleProduct(
                        name: productController
                            .product.value.products![index].title
                            .toString(),
                        description: productController
                            .product.value.products![index].description
                            .toString(),
                        rating: productController
                            .product.value.products![index].rating!
                            .toDouble(),
                        price: productController
                            .product.value.products![index].price!,
                        imageUrl: productController
                            .product.value.products![index].thumbnail
                            .toString()));
                  },
                  child: productController.product.value.products![index].category=="file"?
                   ListTile(
                    title: Text(productController
                        .product.value.products![index].title
                        .toString()),
                    subtitle: Text(
                      productController
                          .product.value.products![index].description
                          .toString(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    leading: 
                    //  (productController.product.value.products![index].thumbnail != null && File(productController.product.value.products![index].thumbnail!).existsSync())?
                    Image.file(
                      File(productController.product.value.products![index].thumbnail!),
                       width: 70.0,
                       height: 70.0,
    fit: BoxFit.cover,
                    )
                    // :Text("data")
                    ,
                    trailing: Column(
                      children: [
                        const SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.star),
                            Text(productController
                                .product.value.products![index].rating
                                .toString())
                          ],
                        ),
                        Text(
                          "  \$ ${productController.product.value.products![index].price}",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ):
                  ListTile(
                    title: Text(productController
                        .product.value.products![index].title
                        .toString()),
                    subtitle: Text(
                      productController
                          .product.value.products![index].description
                          .toString(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    leading: Image.network(
                      productController.product.value.products![index].thumbnail
                          .toString(),
                      width: 70.0,
                    ),
              
                    trailing: Column(
                      children: [
                        const SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.star),
                            Text(productController
                                .product.value.products![index].rating
                                .toString())
                          ],
                        ),
                        Text(
                          "  \$ ${productController.product.value.products![index].price}",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
               
                );
              },
              separatorBuilder: (context, index) => const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
              itemCount: productController.product.value.products == null
                  ? 0
                  : productController.product.value.products!.length)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddProduct());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
