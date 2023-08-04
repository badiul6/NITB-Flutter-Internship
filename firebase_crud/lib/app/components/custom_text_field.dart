import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final int? maxlines;
  final TextEditingController controller;
  const CustomTextField({required this.label, required this.controller, this.maxlines,super.key});

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      
      controller: controller,
      maxLines: maxlines,
              decoration: InputDecoration(
                
                label: Text(label),
                border: const OutlineInputBorder()
              ),
            );
  }
}