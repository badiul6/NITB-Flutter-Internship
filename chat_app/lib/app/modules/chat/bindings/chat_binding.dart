import 'package:get/get.dart';

import 'package:chat_app/app/modules/chat/controllers/select_media_controller.dart';

import '../controllers/chat_controller.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectMediaController>(
      () => SelectMediaController(),
    );
    Get.lazyPut<ChatController>(
      () => ChatController(),
    );
  }
}
