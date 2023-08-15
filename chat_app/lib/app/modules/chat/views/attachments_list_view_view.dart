import 'package:chat_app/app/modules/chat/controllers/select_media_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class AttachmentsListViewView extends GetView<SelectMediaController> {
   const AttachmentsListViewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const ListTile(
          leading: Icon(Icons.camera_alt),
          horizontalTitleGap: 0,
          title: Text('Camera'),
        ),
        InkWell(
          onTap: () {
          
            controller.pickMedia();
          },
          child: const ListTile(
            leading: Icon(Icons.photo_sharp),
            horizontalTitleGap: 0,
            title: Text('Gallery'),
          ),
        ),
        const ListTile(
          leading: Icon(Icons.text_snippet),
          horizontalTitleGap: 0,
          title: Text('Document'),
        )
      ],
    );
  }
}
