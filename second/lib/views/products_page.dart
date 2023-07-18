import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second/controllers/products_controller.dart';
import 'package:second/views/add_product_page.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  ProductController productController = Get.put(ProductController());
  late int total;
  @override
  Widget build(BuildContext context) {
    total = productController.product.value.products == null
        ? 0
        : productController.product.value.products!.length;
    return Scaffold(
      appBar: AppBar(
        title: Text(" Products: $total"),
      ),
      body: Obx(() => productController.isLoading.isTrue
          ? const Center(child: CircularProgressIndicator())
          : ListView.separated(
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {},
                  child: ListTile(
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
          Get.to(const AddProduct());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
