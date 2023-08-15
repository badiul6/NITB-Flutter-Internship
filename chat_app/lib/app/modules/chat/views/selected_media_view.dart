import 'dart:io';
import 'package:chat_app/app/modules/chat/controllers/select_media_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

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
          Obx(() => 
           controller.medias[controller.media.value].name.isVideoFileName
                ? InkWell(
                    onTap: () {
                      controller.togglePlaying();
                    },
                    child: Stack(alignment: Alignment.center, children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height*0.4,
                      

                        child: AspectRatio(
                          aspectRatio: controller.vController.value.aspectRatio,
                          child: VideoPlayer(controller.vController),
                        ),
                      ),
                       Visibility(
                            visible: !controller.isPlaying.value
                            ,
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
                  height: MediaQuery.of(context).size.height*0.4,
                  child: Image.file(
                      File(controller.medias[controller.media.value].path),
                      height: MediaQuery.of(context).size.height * 0.5,
                    ),
                ),),
          
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.10,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.07,
            child: ListView.builder(
              itemCount: controller.medias.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
               
                return InkWell(
                  onTap: () {
                    controller.media.value = index;
                   
                      controller.vController.dispose();
                   

                    controller.initializeVideoController(index);
                  },
                  child: Obx(() {
                    final uint8list =  VideoThumbnail.thumbnailData(
  video: controller.medias[index].path,
  imageFormat: ImageFormat.JPEG,
  maxWidth: 128, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
  quality: 25,
);
                   return 
                  //  controller.medias[index].name.isVideoFileName?
                  //  AspectRatio(
                  //   aspectRatio: controller.vController.value.aspectRatio,
                  //   child: VideoPlayer(controller.vController))
                  // :
                   Container(
                        margin: const EdgeInsets.only(right: 2),
                        width: MediaQuery.of(context).size.width * 0.17,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 2.0,
                                color: controller.media.value == index
                                    ? Colors.green
                                    : Colors.transparent)),
                        // child: Image.file(
                        //   File(controller.medias[index].path),
                        //   fit: BoxFit.fill,
                        // ),
                        child: Image.file(
                          File(controller.medias[index].path),
                          fit: BoxFit.fill,
                        ),
                      );
                      } ),
                );
              },
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(100, 40),
                  backgroundColor: const Color.fromARGB(255, 77, 139, 79)),
              onPressed: () {},
              child: const Text('Send'))
        ],
      ),
    );
  }
}
