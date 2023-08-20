import 'dart:io';
import 'package:path/path.dart' as p;

import 'package:chat_app/app/modules/chat/controllers/chat_controller.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class SelectMediaController extends GetxController {
  RxList<XFile> medias = <XFile>[].obs;
  RxInt media = 0.obs;
  RxBool video = false.obs;
  final controller = Get.find<ChatController>();
  RxInt selectedIndex = 0.obs;

  RxList<VideoPlayerController> vController = <VideoPlayerController>[].obs;
  RxBool isPlaying = false.obs;
  RxInt i = 0.obs;
  final storageInstance = FirebaseStorage.instance;

  Future<void>uploadFiles()async {

    for (var element in medias) {
      String id = DateTime.now().millisecondsSinceEpoch.toString();
      //  controller.percentage.add(0);
          
      id = id + p.extension(element.path);
      String contentType=element.name.isVideoFileName? 'video':'picture';
      final storageRef = storageInstance.ref('chat_files/$id');
      final uploadTask = storageRef.putFile(File(element.path));
      String i =await controller.addMedia('', contentType);
      uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) async {
        switch (taskSnapshot.state) {
          case TaskState.running:

          controller.percentage.value=100.0 *
                (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
              
         
            
            //  print(controller.percentage[0].toString());
            print("Upload is ${controller.percentage.value}% complete.");
            break;
          case TaskState.paused:
            print("Upload is paused.");
            break;
          case TaskState.canceled:
            print("Upload was canceled");
            break;
          case TaskState.error:
            // Handle unsuccessful uploads
            break;
          case TaskState.success:
            String url = await storageRef.getDownloadURL();
            print('task uploaded succesfully');
            print(i);
            controller.updateMediaMsg(i.toString(),url);
            break;
        }
      });

    }
    
  }

  disposeVideos() {
    for (var element in vController) {
      element.dispose();
    }
  }

  initialVideo() {
    medias[0].name.isVideoFileName ? video.value = true : false;
    List<VideoPlayerController> videoList = [];

    for (int i = 0; i < medias.length; i++) {
      if (medias[i].name.isVideoFileName) {
        final video = VideoPlayerController.file(File(medias[i].path));
        video.initialize();

        video.setLooping(true);
        videoList.add(video);
      }
      vController.assignAll(videoList);
    }
  }

  onTapList(index) {
    selectedIndex.value = index;
    if (medias[index].name.isVideoFileName) {
      video.value = true;
      media.value = vController.indexWhere((element) =>
          element.dataSource.replaceFirst(RegExp(r'file://'), '') ==
          medias[index].path);
    } else {
      video.value = false;

      media.value = index;
    }
  }

  togglePlaying(index) {
    if (vController[index].value.isPlaying) {
      vController[index].pause();
      isPlaying.value = false;
    } else {
      // If the video is paused, play it.
      vController[index].play();
      isPlaying.value = true;
    }
  }

  pickMedia() async {
    final ImagePicker picker = ImagePicker();

    medias.value = await picker.pickMultipleMedia();

    controller.view.value = 1;

    initialVideo();
  }

  changeView(int i) {
    controller.view.value = i;
  }
}
