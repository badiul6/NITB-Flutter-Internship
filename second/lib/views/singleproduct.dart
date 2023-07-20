import 'package:flutter/material.dart';

class SingleProduct extends StatelessWidget {
  final String name;
  final String description;
  final double rating;
  final int price;
  final String imageUrl;
  const SingleProduct(
      {super.key,
      required this.name,
      required this.description,
      required this.rating,
      required this.price,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detailed Info"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                
                decoration: const BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 8,
                    blurRadius: 10,
                    offset: Offset(0, 0),
                  )
                ]),
                child: Image.network(
                  
                  imageUrl,
                  height: 300,
                ),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Row(
              children: [
                Flexible(
                    child: Text(
                  name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 24.0),
                )),
                const Spacer(
                  flex: 1,
                ),
                const Icon(Icons.star),
                Text(
                  rating.toString(),
                  style: const TextStyle(fontSize: 18.0),
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            RichText(
                text: TextSpan(
                    text: "Price: ",
                    style: const TextStyle(fontSize: 20.0, color: Colors.black),
                    children: [
                  TextSpan(
                      text: "\$ $price",
                      style: const TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black))
                ])),
            const SizedBox(
              height: 20.0,
            ),
            const Text(
              "Description:",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Text(description, style: const TextStyle(fontSize: 18.0))
          ],
        ),
      ),
    );
  }
}
