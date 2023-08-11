import 'package:chat_app/app/modules/chat/controllers/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({Key? key}) : super(key: key);
  Future<void> _showAlertDialog(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog( // <-- SEE HERE
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 170, 224, 179),
      appBar: AppBar(
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

                    _showAlertDialog(context);
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
      ),
      body: Column(
        children: [
          Expanded(
              child: Obx(
            () => ListView.builder(
                controller: controller.scrollController,
                reverse: true,
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  int reversedIndex = controller.messages.length - 1 - index;
                  print(controller.isHighlight[reversedIndex]);
                  return GestureDetector(
                      onTap: () {
                        if (controller.wantsToDelete.isTrue) {
                          controller
                              .addToDelete(controller.messages[reversedIndex]);
                          controller.isHighlight[reversedIndex] =
                              !controller.isHighlight[reversedIndex];
                        }
                      },
                      onLongPress: () {
                        controller.wantsToDelete.value = true;

                        controller.isHighlight[reversedIndex] =
                            !controller.isHighlight[reversedIndex];
                        debugPrint('anka');
                        controller
                            .addToDelete(controller.messages[reversedIndex]);
                      },
                      child: Obx(
                        () => Stack(children: [
                          Align(
                            alignment:
                                controller.messages[reversedIndex].from !=
                                        'Badiul'
                                    ? Alignment.centerLeft
                                    : Alignment.centerRight,
                            child: Padding(
                              padding:
                                  controller.messages[reversedIndex].from !=
                                          'Badiul'
                                      ? const EdgeInsets.only(
                                          right: 70.0,
                                        )
                                      : const EdgeInsets.only(left: 70.0),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: controller
                                                .messages[reversedIndex].from ==
                                            'Badiul'
                                        ? const BorderRadius.only(
                                            topLeft: Radius.circular(20.0),
                                            topRight: Radius.zero,
                                            bottomLeft: Radius.circular(20.0),
                                            bottomRight: Radius.circular(20.0))
                                        : const BorderRadius.only(
                                            topLeft: Radius.zero,
                                            topRight: Radius.circular(20.0),
                                            bottomLeft: Radius.circular(20.0),
                                            bottomRight: Radius.circular(
                                                20.0)) // Adjust the radius as needed
                                    ),
                                elevation: 0,
                                color: controller
                                            .messages[reversedIndex].from !=
                                        'Badiul'
                                    ? const Color.fromRGBO(146, 183, 137, 1)
                                    // ? const Color.fromARGB(255, 205, 205, 205)

                                    : const Color.fromARGB(255, 96, 157, 137),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0,
                                      left: 8.0,
                                      right: 8.0,
                                      bottom: 5.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: controller
                                                .messages[reversedIndex].from !=
                                            'Badiul'
                                        ? CrossAxisAlignment.start
                                        : CrossAxisAlignment.end,
                                    children: [
                                      Visibility(
                                        visible: controller
                                                .messages[reversedIndex].from !=
                                            'Badiul',
                                        child: Text(
                                          controller
                                              .messages[reversedIndex].from,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Visibility(
                                          visible: controller
                                                  .messages[reversedIndex]
                                                  .from !=
                                              'badiul',
                                          child: const SizedBox(
                                            height: 7.0,
                                          )),
                                      RichText(
                                        textAlign: controller
                                                    .messages[reversedIndex]
                                                    .from ==
                                                'Badiul'
                                            ? TextAlign.end
                                            : TextAlign.start,
                                        textDirection: TextDirection.ltr,
                                        text: TextSpan(
                                          text: controller
                                              .messages[reversedIndex].content,
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: controller
                                                          .messages[
                                                              reversedIndex]
                                                          .from ==
                                                      'Badiul'
                                                  ? Colors.black
                                                  : Colors.black),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            controller.formatTime(controller
                                                .messages[reversedIndex].at
                                                .toDate()),
                                            style: TextStyle(
                                                color: controller
                                                            .messages[
                                                                reversedIndex]
                                                            .from ==
                                                        'Badiul'
                                                    ? Colors.black
                                                    : Colors.black),
                                          ),
                                          Visibility(
                                              visible: controller
                                                      .messages[reversedIndex]
                                                      .from ==
                                                  'Badiul',
                                              child: controller
                                                          .messages[
                                                              reversedIndex]
                                                          .status ==
                                                      'Sent'
                                                  ? const Icon(
                                                      Icons.check,
                                                      size: 18,
                                                      color: Colors.black,
                                                    )
                                                  : const Icon(
                                                      Icons.schedule,
                                                      size: 18,
                                                      color: Colors.black,
                                                    )),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned.fill(
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 4.0),
                              color:
                                  controller.isHighlight[reversedIndex] == true
                                      ? Colors.grey.withOpacity(0.3)
                                      : Colors.transparent,
                            ),
                          ),
                        ]),
                      ));
                }),
          )),
          TextFormField(
            onTap: () {
            controller.wantsToDelete.value=false;
            controller.deleteMessages.clear();
            for(int i=0; i<controller.isHighlight.length; i++){
              if(controller.isHighlight[i]=true) {
                controller.isHighlight[i]=false;
              }
            }
            
            print('List==');
            print(controller.isHighlight);
            },
            controller: controller.messageController,
            decoration: InputDecoration(
                hintStyle: const TextStyle(color: Colors.black),
                hintText: "Enter message",
                filled: true,
                fillColor: Colors.white38,
                suffixIcon: IconButton(
                  onPressed: () {
                    controller.addMessage(controller.messageController.text);
                    controller.messageController.clear();
                  },
                  icon: const Icon(
                    Icons.send,
                    color: Color.fromARGB(255, 42, 99, 44),
                    size: 30,
                  ),
                ),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(40))),
          )
        ],
      ),
    );
  }
}
