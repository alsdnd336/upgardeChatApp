import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String receiverId;
  final String senderId;
  final String senderEmail;
  final Timestamp timestamp;
  final String message;

  Message(
      {required this.receiverId,
      required this.senderEmail,
      required this.senderId,
      required this.timestamp,
      required this.message});

  Map<String, dynamic> toMap() {
    return {
      'receiverId' : receiverId,
      'senderId' : senderId,
      'senderEmail' : senderEmail,
      'timestamp' : timestamp,
      'message' : message
    };
  }
}
