import 'package:cloud_firestore/cloud_firestore.dart';

import '../constant.dart';

class Message {
  final String message;
  final String id;
  final DateTime createdAt;

  Message(this.message, {required this.id, required this.createdAt});

  factory Message.fromJson(jsonData) {
    return Message(
      jsonData[Constant.kMessage],
      id: jsonData['id'],
      createdAt: (jsonData[Constant.kCreatedAt] as Timestamp)
          .toDate(), // تحويل من نوع Timestamp إلى DateTime
    );
  }
}
