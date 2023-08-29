import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../controllers/playvideo_controller.dart';

class PlayvideoView extends GetView<PlayvideoController> {
  const PlayvideoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      body: InkWell(
        onTap: () {
          controller.isFocus.value = !controller.isFocus.value;
        },
        child: Stack(
          children: [
            Center(
              child: Obx(() => AspectRatio(
                    aspectRatio: controller.videoController!.value.aspectRatio,
                    child: controller.isInitialized.isTrue
                        ? Padding(
                          padding: const EdgeInsets.only(bottom: 80.0),
                          child: VideoPlayer(controller.videoController!),
                        )
                        : const Center(
                            child: CircularProgressIndicator(
                            color: Colors.white,
                          )),
                  )),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: VideoProgressIndicator(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
                controller.videoController!,
                allowScrubbing: true,
                colors: const VideoProgressColors(
                  playedColor: Colors.white,
                ),
              ),
            ),

            // SizedBox(
            //   height: 60,
            //   width: 50,
            //   child: Align(
            //     alignment: Alignment.topCenter,
            //     child: ClosedCaption(
            //       text: controller.videoController!.value.caption.text,
            //       textStyle: TextStyle(
            //         color: Colors.black,
            //         fontSize: 32
            //       ),
            //     ),
            //   ),
            // )
            //,
            Obx(
              () => Visibility(
                visible: controller.isFocus.value,
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      height: 60,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            IconButton(
                                onPressed: () {
                                  controller.playVideo();
                                },
                                icon: controller.isPlaying.isTrue
                                    ? const Icon(
                                        Icons.pause,
                                        color: Colors.white,
                                        size: 30,
                                      )
                                    : const Icon(
                                        Icons.play_arrow,
                                        size: 30,
                                        color: Colors.white,
                                      )),

                            // Expanded(child: Slider(value: 1, onChanged: (val) {})),

                            IconButton(
                                onPressed: () {
                                  controller.muteVideo();
                                },
                                icon: controller.isMute.isTrue
                                    ? const Icon(
                                        Icons.volume_off,
                                        color: Colors.white,
                                      )
                                    : const Icon(
                                        Icons.volume_up,
                                        color: Colors.white,
                                      )),
                            const Expanded(child: SizedBox()),
                            IconButton(
                                onPressed: () {
                                  controller.changeOrientation(context);
                                },
                                icon: const Icon(
                                  Icons.fullscreen,
                                  color: Colors.white,
                                ))
                          ],
                        ),
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
