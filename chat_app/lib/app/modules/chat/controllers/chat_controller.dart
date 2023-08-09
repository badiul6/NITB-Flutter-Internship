
import 'package:chat_app/app/models/messages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  
  RxList<Message> messages = <Message>[].obs;
  FirebaseFirestore db = FirebaseFirestore.instance;
  final ScrollController scrollController = ScrollController();
  RxList<bool> isHighlight= <bool>[].obs;
  RxBool wantsToDelete= false.obs;
  RxList<Message> deleteMessages= <Message>[].obs;
  TextEditingController messageController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getMessages();
  }
  void _scrollDown() {
  scrollController.animateTo(
    scrollController.position.minScrollExtent,
    duration: const Duration(milliseconds: 500),
    curve: Curves.fastOutSlowIn,
  );
}

void addToDelete(Message m){
  deleteMessages.add(m);
  print(deleteMessages[0].content);
}
void deleteProduct() {

  deleteMessages.forEach((element) {
     db.collection("messages").doc(element.id).delete().then(
          (doc) => print("Document deleted"),
          onError: (e) => print("Error updating document $e"),
        );
   });
   deleteMessages.clear();
   
  }

  void addMessage(String content) async {
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    DateTime now= DateTime.now();
    print(now.toString());
    Message m =
        Message(content: content, from: 'Badiul', id: id, status: 'Pending', at: now);

    final ref = db.collection('messages').doc(id);
    ref.set(m.toFirestore()).then((value) {
      ref.update({'status': 'Sent'});
    }).onError((error, stackTrace) {});
    _scrollDown();
  }

  void sentPendingMsgs() async {
    await db.waitForPendingWrites().whenComplete(() {
        db
          .collection('messages')
          .where('status', isEqualTo: 'Pending')
          .get()
          .then((value) {
        for (var query in value.docs) {
          query.reference.update({'status': 'Sent'});
        }
      });
    });
  }

  void getMessages() {
    db.collection('messages').snapshots().listen(
      (event) {
        sentPendingMsgs();
       
        messages.assignAll(
          event.docs.map((doc) => Message.fromFirestore(doc)).toList(),
        );
        isHighlight.assignAll(List.generate(messages.length, (index) => false));
        print(isHighlight);
      },
      onError: (error) => debugPrint("Listen failed: $error"),
    
    );
  }

  String formatTime(DateTime dateTime) {
    print('Time'+dateTime.toString());
  int hour = dateTime.hour;
  int minute = dateTime.minute;
  String period = hour < 12 ? 'AM' : 'PM';

  // Convert hour to 12-hour format
  if (hour > 12) {
    hour -= 12;
  } else if (hour == 0) {
    hour = 12;
  }

  // Format the time as "h : mm AM/PM"
  String formattedTime = '$hour:${minute.toString().padLeft(2, '0')} $period';
  return formattedTime;
}
}
