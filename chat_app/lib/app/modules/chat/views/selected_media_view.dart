import 'dart:io';
import 'package:chat_app/app/modules/chat/controllers/select_media_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class SelectedMediaView extends GetView<SelectMediaController> {
  const SelectedMediaView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Obx(
            () => controller.video.isTrue
                ? InkWell(
                    onTap: () {
                      controller.togglePlaying(controller.media.value);
                    },
                    child: Stack(alignment: Alignment.center, children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: Obx(() => AspectRatio(
                          aspectRatio: controller
                              .vController[controller.media.value]
                              .value
                              .aspectRatio,
                          child: VideoPlayer(
                              controller.vController[controller.media.value]),
                        ),)
                      ),
                      Visibility(
                        visible: !controller.isPlaying.value,
                        child: Center(
                          child: CircleAvatar(
                            radius: 25.0,
                            backgroundColor: Colors.blue.withOpacity(0.7),
                            child: Icon(Icons.play_arrow),
                          ),
                        ),
                      )
                    ]),
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Obx(() => Image.file(
                          File(controller
                              .medias[controller.selectedIndex.value].path),
                          height: MediaQuery.of(context).size.height * 0.5,
                        ))),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.10,
          ),
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.07,
              child: Obx(() => ListView.builder(
                    itemCount: controller.medias.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          controller.onTapList(index);
                        },
                        child: Obx(() => Container(
                              margin: const EdgeInsets.only(right: 2),
                              width: MediaQuery.of(context).size.width * 0.17,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 2.0,
                                      color: controller.selectedIndex.value ==
                                              index
                                          ? Colors.green
                                          : Colors.transparent)),
                              child: controller
                                      .medias[index].name.isVideoFileName
                                  ? AspectRatio(
                                      aspectRatio: controller
                                          .vController[controller.vController.indexWhere((element) =>
                                              element.dataSource.replaceFirst(
                                                  RegExp(r'file://'), '') ==
                                              controller.medias[index].path)]
                                          .value
                                          .aspectRatio,
                                      child: VideoPlayer(controller.vController[
                                          controller.vController.indexWhere((element) =>
                                              element.dataSource.replaceFirst(
                                                  RegExp(r'file://'), '') ==
                                              controller.medias[index].path)]))
                                  : Image.file(
                                      File(controller.medias[index].path),
                                      fit: BoxFit.fill,
                                    ),
                            )),
                      );
                    },
                  ))),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(100, 40),
                  backgroundColor: const Color.fromARGB(255, 77, 139, 79)),
              onPressed: () {
                controller.uploadFiles();
                controller.changeView(0);
              },
              child: const Text('Send'))
        ],
      ),
    );
  }
}
