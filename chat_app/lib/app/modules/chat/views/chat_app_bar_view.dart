import 'package:chat_app/app/modules/chat/controllers/chat_controller.dart';
import 'package:chat_app/app/modules/chat/controllers/select_media_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class ChatAppBar {
  static appBar(
      {required ChatController controller, required BuildContext context}) {
    if (controller.view.value == 0) {
      return AppBar(
        backgroundColor: const Color.fromARGB(255, 42, 99, 44),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        actions: [
          Obx(() => Visibility(
              visible: controller.wantsToDelete.value,
              child: IconButton(
                  onPressed: () {
                    _showAlertDialog(context, controller);
                  },
                  icon: const Icon(Icons.delete))))
        ],
        elevation: 2,
        title: Obx(
          () => controller.wantsToDelete.isFalse
              ? const Text('Group Chat',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500))
              : Text('${controller.deleteMessages.length} message(s) selected',
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500)),
        ),
        centerTitle: true,
      );
    } else if (controller.view.value == 1) {
      final control = Get.find<SelectMediaController>();

      return AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              controller.view.value = 0;
              control.disposeVideos();
            },
            icon: const Icon(Icons.close)),
        title: const Text('# items selected'),
        actions: [
          IconButton(
              onPressed: () {
                if (control
                    .medias[control.selectedIndex.value].name.isVideoFileName) {
                  List<VideoPlayerController> videos = [];
                  videos = control.vController;
                  videos
                      .elementAt(control.vController.indexWhere((element) =>
                          element.dataSource
                              .replaceFirst(RegExp(r'file://'), '') ==
                          control.medias[control.selectedIndex.value].path))
                      .dispose();
                  videos.removeAt(control.vController.indexWhere((element) =>
                      element.dataSource.replaceFirst(RegExp(r'file://'), '') ==
                      control.medias[control.selectedIndex.value].path));

                  control.video.value = false;
                }
                List<XFile> media = [];

                media = control.medias;

                media.removeAt(control.selectedIndex.value);

                if (control.medias.isEmpty) {
                  controller.view.value = 0;
                }
                print(control.selectedIndex.value);
                print(control.medias.length);
                if (control.selectedIndex.value <= control.medias.length - 1) {
                  if (control.medias[control.selectedIndex.value].name
                      .isVideoFileName) {
                    control.media.value = control.vController.indexWhere(
                        (element) =>
                            element.dataSource
                                .replaceFirst(RegExp(r'file://'), '') ==
                            control.medias[control.selectedIndex.value].path);
                  }
                }

                if (control.selectedIndex.value == control.medias.length &&
                    control.selectedIndex.value != 0) {
                  control.selectedIndex.value--;
                  if (control.medias[control.selectedIndex.value].name
                      .isVideoFileName) {
                    control.media.value = control.vController.indexWhere(
                        (element) =>
                            element.dataSource
                                .replaceFirst(RegExp(r'file://'), '') ==
                            control.medias[control.selectedIndex.value].path);
                  }
                }

                if ((control.selectedIndex.value != 0 ||
                        control.selectedIndex.value != control.medias.length) &&
                    control.medias[control.selectedIndex.value].name
                        .isVideoFileName) {
                  control.video.value = true;
                }
              },
              icon: const Icon(Icons.delete))
        ],
      );
    }
    return null;
  }

  static Future<void> _showAlertDialog(context, controller) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // <-- SEE HERE
          title: const Text('Delete message(s)?'),

          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                controller.delete();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
