import 'package:chat_app/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatService extends ChangeNotifier {
  // firebase instance
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  // send Message
  Future<void> sendMessage(receiverId, message) async {
    // current User Information
    final String currentUserEmail = _auth.currentUser!.email.toString();
    final String currentUserId = _auth.currentUser!.uid;
    Timestamp timestamp = Timestamp.now();

    // document name
    List commentNameElement = [currentUserId, receiverId];
    commentNameElement.sort();
    String CommentName = commentNameElement.join("_");

    // newMesage
    Message newMessage = Message(
        receiverId: receiverId,
        senderEmail: currentUserEmail,
        senderId: currentUserId,
        timestamp: timestamp,
        message: message);

    // fireStore data save
    await _firestore
        .collection('chat_rooms')
        .doc(CommentName)
        .collection('message')
        .add(newMessage.toMap());
        
  }

  // Get Message
  Stream<QuerySnapshot> getMessage(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('message')
        .orderBy('timestamp', descending: false) // collection 안에 document 들을 다 대려온다.
        .snapshots();
  }
}
