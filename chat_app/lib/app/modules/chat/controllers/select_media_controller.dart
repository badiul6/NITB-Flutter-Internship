import 'dart:io';

import 'package:chat_app/app/modules/chat/controllers/chat_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class SelectMediaController extends GetxController {
  RxList<XFile> medias = <XFile>[].obs;
  RxInt media = 0.obs;
  final controller = Get.find<ChatController>();
  late RxList VideoPlayerController vController= ;
  RxBool isPlaying = false.obs;
  RxInt i = 0.obs;

  initialVideo() {
    for (var element in medias) {
      if (element.name.isVideoFileName) {
        vController = VideoPlayerController.file(File(medias[0].path));
        vController.initialize();
        break;
      }
    }
  }

  initializeVideoController(index) {
    if (medias[index].name.isVideoFileName) {
      vController = VideoPlayerController.file(File(medias[index].path));
      vController.initialize();
      print('initialize');
    }
  }

  togglePlaying() {
    if (vController.value.isPlaying) {
      vController.pause();
      isPlaying.value = false;
    } else {
      // If the video is paused, play it.
      vController.play();
      isPlaying.value = true;
    }
  }

  pickMedia() async {
    final ImagePicker picker = ImagePicker();

    medias.value = await picker.pickMultipleMedia();
    controller.view.value = 1;

    initialVideo();
  }
}
