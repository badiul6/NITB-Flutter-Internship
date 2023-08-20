import 'package:chat_app/app/modules/chat/controllers/chat_controller.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class PlayVideoController extends GetxController {

  late VideoPlayerController vController;
  final controller = Get.find<ChatController>();
  RxBool isPlaying= false.obs;
RxBool isInitialized= false.obs;
  @override
  void onInit() {
    super.onInit();
  }
  initial(){
    vController= VideoPlayerController.networkUrl(Uri.parse(controller.currentVideo.value))..initialize().then((_) => isInitialized.value=true);

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
  goBack(){
   
    controller.view.value=0;
    isInitialized.value=false;
    vController.dispose();
     
  }
 


}
