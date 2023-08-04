import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:second/models/picture.dart';
class PictureController extends GetxController {
  Rx<Picture> pic = Picture().obs;

  getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );

    if (pickedFile != null) {

      // pic.value.imageFile = File(pickedFile.path);

      pic.update((picture) {
      
        picture!.imageFile = File(pickedFile.path);

      });

      // print(pic.value.imageFile);
    }
  }
}
