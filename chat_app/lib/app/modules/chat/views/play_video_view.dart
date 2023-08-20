import 'package:chat_app/app/modules/chat/controllers/play_video_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class PlayVideoView extends GetView<PlayVideoController> {
  const PlayVideoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            
            Obx(() => InkWell(
                  onTap: () {
                    controller.togglePlaying();
                  },
                  child: controller.isInitialized.value?Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: controller.vController.value.aspectRatio,
                        child: VideoPlayer(controller.vController),
                      ),
                      Positioned(
                        bottom: 300,
                        left: 180,
          
                        child: Visibility(
                              visible: (!controller.isPlaying.value)&&controller.isInitialized.value,
                              child: const CircleAvatar(
                                child: Icon(Icons.play_arrow),
                              ),
                            ),
                      )
                    ],
                  ):   CircularProgressIndicator(),
                  
                )),
                ElevatedButton(onPressed: (){
                  controller.goBack();
                }, child: const Text("Back"))
          ],
        ),
      ),
    );
  }
}
