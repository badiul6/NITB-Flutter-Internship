import 'package:get/get.dart';

import '../controllers/playvideo_controller.dart';

class PlayvideoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlayvideoController>(
      () => PlayvideoController(),
    );
  }
}
