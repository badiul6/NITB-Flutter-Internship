
import 'package:chat_app/app/modules/chat/controllers/chat_controller.dart';
import 'package:chat_app/app/modules/chat/controllers/play_video_controller.dart';
import 'package:chat_app/app/modules/chat/views/attachments_list_view_view.dart';
import 'package:chat_app/app/modules/chat/views/chat_app_bar_view.dart';
import 'package:chat_app/app/modules/chat/views/display_content_view.dart';
import 'package:chat_app/app/modules/chat/views/play_video_view.dart';
import 'package:chat_app/app/modules/chat/views/selected_media_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatView extends GetView<ChatController> {
   ChatView({Key? key}) : super(key: key);
    final playController = Get.find<PlayVideoController>();


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Obx(
      () => Scaffold(
          // backgroundColor: Colors.black54,
          backgroundColor: const Color.fromARGB(255, 170, 224, 179),
          appBar: ChatAppBar.appBar(controller: controller, context: context),
          body: Obx(() {
            if(controller.view.value == 0){
              return Column(
                  children: [
                    Expanded(
                        child: Obx(
                      () => Stack(
                        children: [
                          ListView.builder(
                              controller: controller.scrollController,
                              reverse: true,
                              itemCount: controller.messages.length,
                              itemBuilder: (context, index) {
                                int reversedIndex =
                                    controller.messages.length - 1 - index;
                                return InkWell(
                                    onTap: () => controller
                                        .onTapSelection(reversedIndex),
                                    onLongPress: () => controller
                                        .onLongPressSelection(reversedIndex),
                                        onDoubleTap: () {
                                          if(controller.messages[reversedIndex].contentType == 'video' &&
        controller.messages[reversedIndex].content != ""){
controller.currentVideo.value= controller.messages[reversedIndex].content;
                                          controller.view.value=2;
                                          playController.initial();
                                          
        }
                                          
                                        },
                                    child: Obx(
                                      () => Stack(children: [
                                        Align(
                                          alignment: controller
                                                      .messages[reversedIndex]
                                                      .from !=
                                                  'Badiul'
                                              ? Alignment.centerLeft
                                              : Alignment.centerRight,
                                          child: Padding(
                                            padding: controller
                                                        .messages[reversedIndex]
                                                        .from !=
                                                    'Badiul'
                                                ? const EdgeInsets.only(
                                                    right: 70.0,
                                                  )
                                                : const EdgeInsets.only(
                                                    left: 70.0),
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: controller
                                                              .messages[
                                                                  reversedIndex]
                                                              .from ==
                                                          'Badiul'
                                                      ? const BorderRadius.only(
                                                          topLeft: Radius.circular(
                                                              20.0),
                                                          topRight: Radius.zero,
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  20.0),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  20.0))
                                                      : const BorderRadius.only(
                                                          topLeft: Radius.zero,
                                                          topRight: Radius.circular(
                                                              20.0),
                                                          bottomLeft:
                                                              Radius.circular(20.0),
                                                          bottomRight: Radius.circular(20.0))),
                                              elevation: 0,
                                              color: controller
                                                          .messages[
                                                              reversedIndex]
                                                          .from !=
                                                      'Badiul'
                                                  ? const Color.fromRGBO(
                                                      146, 183, 137, 1)
                                                  : const Color.fromARGB(
                                                      255, 96, 157, 137),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0,
                                                    left: 8.0,
                                                    right: 8.0,
                                                    bottom: 5.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment: controller
                                                              .messages[
                                                                  reversedIndex]
                                                              .from !=
                                                          'Badiul'
                                                      ? CrossAxisAlignment.start
                                                      : CrossAxisAlignment.end,
                                                  children: [
                                                    Visibility(
                                                      visible: controller
                                                              .messages[
                                                                  reversedIndex]
                                                              .from !=
                                                          'Badiul',
                                                      child: Text(
                                                        controller
                                                            .messages[
                                                                reversedIndex]
                                                            .from,
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    Visibility(
                                                        visible: controller
                                                                .messages[
                                                                    reversedIndex]
                                                                .from !=
                                                            'badiul',
                                                        child: const SizedBox(
                                                          height: 7.0,
                                                        )),
          //                                               RichText(
          //   textAlign: controller
          //               .messages[
          //                   reversedIndex]
          //               .from ==
          //           'Badiul'
          //       ? TextAlign.end
          //       : TextAlign.start,
          //   textDirection: TextDirection.ltr,
          //   text: TextSpan(
          //     text: controller
          //         .messages[reversedIndex]
          //         .content,
          //     style: TextStyle(
          //         fontSize: 18,
          //         color: controller
          //                     .messages[
          //                         reversedIndex]
          //                     .from ==
          //                 'Badiul'
          //             ? Colors.black
          //             : Colors.black),
          //   ),
          // ),
                                                    DisplayContentView(reversedIndex: reversedIndex, press: () {
                                                      print('object');
                                                    },),
                                                    const SizedBox(
                                                      height: 5.0,
                                                    ),
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                          controller.formatTime(
                                                              controller
                                                                  .messages[
                                                                      reversedIndex]
                                                                  .at
                                                                  .toDate()),
                                                          style: TextStyle(
                                                              color: controller
                                                                          .messages[
                                                                              reversedIndex]
                                                                          .from ==
                                                                      'Badiul'
                                                                  ? Colors.black
                                                                  : Colors
                                                                      .black),
                                                        ),
                                                        Visibility(
                                                            visible: controller
                                                                    .messages[
                                                                        reversedIndex]
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
                                                                    color: Colors
                                                                        .black,
                                                                  )
                                                                : const Icon(
                                                                    Icons
                                                                        .schedule,
                                                                    size: 18,
                                                                    color: Colors
                                                                        .black,
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
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 4.0),
                                            color: controller.isHighlight[
                                                        reversedIndex] ==
                                                    true
                                                ? Colors.grey.withOpacity(0.3)
                                                : Colors.transparent,
                                          ),
                                        ),
                                      ]),
                                    ));
                              }),
                          Positioned(
                            bottom: 2,
                            left: 5,
                            child: Obx(() => AnimatedContainer(
                                curve: Curves.easeOut,
                                height: controller.attachFile.isTrue ? 170 : 0,
                                width: 150,
                                duration: const Duration(milliseconds: 300),
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 122, 178, 159),
                                    borderRadius: BorderRadius.circular(20)),
                                child:  const AttachmentsListViewView())),
                          )
                        ],
                      ),
                    )),
                    TextFormField(
                      onTap: () => controller.onTapTextField(),
                      controller: controller.messageController,
                      decoration: InputDecoration(
                          hintStyle: const TextStyle(color: Colors.black),
                          hintText: "Enter message",
                          filled: true,
                          fillColor: Colors.white38,
                          prefixIcon: IconButton(
                              onPressed: () {
                                controller.attachFile.value =
                                    !controller.attachFile.value;
                              },
                              icon: const Icon(
                                Icons.attach_file,
                                color: Color.fromARGB(255, 42, 99, 44),
                                size: 24,
                              )),
                          suffixIcon: IconButton(
                            onPressed: () {
                              controller.addMessage(
                                  controller.messageController.text);
                                  
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
                );
            }
            else if(controller.view.value==1){
            return const SelectedMediaView();

          }
          else {
            return const PlayVideoView();
          }
          }
          
           )
    )));
  }
}
