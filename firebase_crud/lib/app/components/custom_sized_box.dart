import 'package:flutter/material.dart';

class CustomSizedBox extends StatelessWidget {
  double? height;
  double? width;
   CustomSizedBox({this.height =0, this.width=0, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
    );
  }
}