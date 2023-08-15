import 'package:chat_app/app/modules/chat/controllers/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatAppBar {
  static appBar(
      {required ChatController controller, required BuildContext context}) {
    if (controller.view.value == 0) {
      return AppBar(
        backgroundColor: const Color.fromARGB(255, 42, 99, 44),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        actions: [
          Obx(() => Visibility(
              visible: controller.wantsToDelete.value,
              child: IconButton(
                  onPressed: () {
                    _showAlertDialog(context, controller);
                  },
                  icon: const Icon(Icons.delete))))
        ],
        elevation: 2,
        title: Obx(
          () => controller.wantsToDelete.isFalse
              ? const Text('Group Chat',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500))
              : Text('${controller.deleteMessages.length} message(s) selected',
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500)),
        ),
        centerTitle: true,
      );
    } else if (controller.view.value == 1) {
      return AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.close)),
        title: Text('# items selected'),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.delete))],
      );
    }
    return null;
  }

  static Future<void> _showAlertDialog(context, controller) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // <-- SEE HERE
          title: const Text('Delete message(s)?'),

          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                controller.delete();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
