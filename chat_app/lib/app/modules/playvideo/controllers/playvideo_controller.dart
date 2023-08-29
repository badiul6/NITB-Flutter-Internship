import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class PlayvideoController extends GetxController {
  RxBool isFocus = false.obs;

  final data = Get.arguments as List<Map<String, String>>;
  VideoPlayerController? videoController;
  RxBool isPlaying = false.obs;
  RxBool isMute = false.obs;
  RxBool isInitialized=false.obs;
  @override
  void onInit() {
    initializeVideo();
    super.onInit();
  }

  initializeVideo() {
    videoController =
        VideoPlayerController.networkUrl(Uri.parse(data[0]['video']!))
          ..initialize().then((value) => isInitialized.value=true);

    videoController!.setLooping(true);
  }

  void playVideo() {
    if (videoController != null && videoController!.value.isInitialized) {
      if (videoController!.value.isPlaying) {
        videoController!.pause();
        isPlaying.value = false;
      } else {
        videoController!.play();
        isPlaying.value = true;
      }
    }
  }

  void muteVideo() {
    if (videoController!.value.volume != 0) {
      videoController!.setVolume(0);
      isMute.value = true;
    } else {
      videoController!.setVolume(1.0);
      isMute.value = false;
    }
  }

  void changeOrientation(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);
    } else {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }
  }

  @override
  void onClose() {
    videoController!.dispose();
    super.onClose();
  }
}
