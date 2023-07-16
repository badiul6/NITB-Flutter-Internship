import 'package:first/Widgets/listtile.dart';
import 'package:first/product.dart';
import 'package:flutter/material.dart';

class BodyView extends StatelessWidget {
  final Future<Product> futureAlbum;
  const BodyView({required this.futureAlbum, super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Product>(
      future: futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final employee = snapshot.data!;
          return ListView.separated(
            itemCount: employee.title.length,
            itemBuilder: (context, index) {
              return CustomListTile(employee: employee, index: index);
            },
            separatorBuilder: (context, index) => const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Divider(
                color: Colors.grey,
              ),
            ),
          );
        } else {
          return const Text('No data available');
        }
      },
    );
  }
}
