import 'package:chat_app/app/models/messages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ChatController extends GetxController {
  RxList<Message> messages = <Message>[].obs;
  FirebaseFirestore db = FirebaseFirestore.instance;
  final ScrollController scrollController = ScrollController();
  RxList<bool> isHighlight = <bool>[].obs;
  RxBool wantsToDelete = false.obs;
  RxList<Message> deleteMessages = <Message>[].obs;
  TextEditingController messageController = TextEditingController();
  RxBool attachFile= false.obs;
  RxInt view=1.obs;
  RxList<XFile> medias= <XFile>[].obs;

  @override
  void onInit() {
    super.onInit();
    getMessages();
  }

  pickMedia() async {
    final ImagePicker picker = ImagePicker();

     medias.value= await picker.pickMultipleMedia();
      view.value = 1;


  }
  void onTapTextField(){
    wantsToDelete.value = false;
    deleteMessages.clear();
    for (int i = 0; i < isHighlight.length; i++) {
      if (isHighlight[i] = true) {
        isHighlight[i] = false;
        }
      }
  }
  void onLongPressSelection(reversedIndex){
    wantsToDelete.value = true;
    isHighlight[reversedIndex] =!isHighlight[reversedIndex];
    addToDelete(messages[reversedIndex]);
  }
  void onTapSelection(reversedIndex){
    if (wantsToDelete.isTrue) {
        addToDelete(messages[reversedIndex]);
        isHighlight[reversedIndex] =
            !isHighlight[reversedIndex];
      }
  }


  void _scrollDown() {
    scrollController.animateTo(
      scrollController.position.minScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }

  void addToDelete(Message m) {
    if (deleteMessages.contains(m)) {
      deleteMessages.remove(m);
      if (deleteMessages.isEmpty) {
        wantsToDelete.value = false;
      }
    } else {
      deleteMessages.add(m);
    }
  }

  void delete() {
    for (var element in deleteMessages) {
      db.collection("messages").doc(element.id).delete().then(
            (doc) => debugPrint("Document deleted"),
            onError: (e) => debugPrint("Error updating document $e"),
          );
    }
    deleteMessages.clear();
    wantsToDelete.value = false;
  }

  void addMessage(String content) async {
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    DateTime now = DateTime.now();
    Message m = Message(
        content: content, from: 'Badiul', id: id, status: 'Pending', at: now);

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
        wantsToDelete.value = false;
        deleteMessages.clear();
      },
      onError: (error) => debugPrint("Listen failed: $error"),
    );
  }

  String formatTime(DateTime dateTime) {
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
