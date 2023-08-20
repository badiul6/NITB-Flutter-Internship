import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String content;
    String id;
   String status;
   dynamic at;
   String contentType;

  String from;
  Message({required this.content, required this.from, required this.id, required this.status, required this.at, required this.contentType});
  
  Map<String, dynamic> toFirestore() {
    return {
      'from': from,
      'content': content,
      'id': id,
      'status': status,
      'at':at,
      'contentType': contentType
    };
  }
  factory Message.fromFirestore(
    DocumentSnapshot<Map<dynamic, dynamic>> snapshot
  ) {
    final data = snapshot.data();
    return Message(
      id: data?['id']??"",
      from: data?['from']??"",
      content: data?['content']??"", 
      status: data?['status']??"",
      at: data?['at']??"",
      contentType: data?['contentType']??""
    );
  }
}
