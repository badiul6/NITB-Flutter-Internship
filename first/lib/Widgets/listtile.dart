import 'package:flutter/material.dart';

import '../singleproduct.dart';

class CustomListTile extends StatelessWidget {
  final dynamic employee;
  final dynamic index;
  const CustomListTile(
      {required this.employee, required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder:(context) => SingleProduct(name: employee.title[index], description: employee.description[index], rating: employee.rating[index], price: employee.price[index], imageUrl: employee.thumbnail[index],)));
      },
      child: ListTile(
        title: Text(employee.title[index]),
        subtitle: Text(
          employee.description[index],
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
        leading: Image.network(
          employee.thumbnail[index],
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
                Text(employee.rating[index].toString())
              ],
            ),
           
            Text(
              "Price: \$${employee.price[index]}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
