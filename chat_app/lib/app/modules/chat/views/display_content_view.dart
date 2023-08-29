import 'package:chat_app/app/modules/chat/controllers/chat_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class DisplayContentView extends GetView<ChatController> {
  final int reversedIndex;
  final Function() press;
  
  const DisplayContentView({Key? key, required this.reversedIndex, required this.press})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (controller.messages[reversedIndex].contentType == 'video' &&
        controller.messages[reversedIndex].content != "") {
      return   Row(
        mainAxisSize: MainAxisSize.min,
        children: [
//           IconButton(onPressed: () {
// print('object');
//             // controller.url.value= controller.messages[reversedIndex].content;
//             // controller.view.value=2;
//           }, icon: const Icon(Icons.play_arrow, size: 30,)),

 GestureDetector(
  onTap:press,
  
  child: const Icon(Icons.play_arrow, size: 40,)),
           const Text("Play Video"),
        ],
      );
    } else if (controller.messages[reversedIndex].contentType == "picture" &&
        controller.messages[reversedIndex].content != "") {
      return Image.network(
        controller.messages[reversedIndex].content);
    } else if ((controller.messages[reversedIndex].contentType == "video" ||
            controller.messages[reversedIndex].contentType == "picture") &&
        controller.messages[reversedIndex].content == "" &&
        controller.messages[reversedIndex].from == "Badiul") {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(() => CircularProgressIndicator(
                value: controller.percentage/100,
                color: Colors.white,
              )),
              const SizedBox(width: 8.0,),
          const Text("Uploading Media"),
          
        ],
      );
    }
    return RichText(
      textAlign: controller.messages[reversedIndex].from == 'Badiul'
          ? TextAlign.end
          : TextAlign.start,
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: controller.messages[reversedIndex].content,
        style: TextStyle(
            fontSize: 18,
            color: controller.messages[reversedIndex].from == 'Badiul'
                ? Colors.white
                : Colors.black),
      ),
    );
  }
}
