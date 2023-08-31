import 'dart:async';

import 'package:chat_app/chat/chat_service.dart';
import 'package:chat_app/components/myTextFormField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserID;
  const ChatPage(
      {required this.receiverUserEmail,
      required this.receiverUserID,
      super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  ChatService _chatService = ChatService();
  final TextEditingController _messageController = TextEditingController();
  final _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverUserID, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverUserEmail),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // messages
            Expanded(
              child: _BuildMessageList(),
            ),
            // userInput
            _BuildMessageInput(),
          ],
        ),
      ),
    );
  }

  // // user Messages
  Widget _BuildMessageList(){
    return StreamBuilder(
      stream: _chatService.getMessage( _firebaseAuth.currentUser!.uid, widget.receiverUserID),
      builder: (context, snapshot){
        if(snapshot.hasData){
          return Text('error : ${snapshot.error}');
        } 
        if(snapshot.connectionState == ConnectionState.waiting){
          return Text('loading ... ');
        }
        return ListView(
          children: snapshot.data!.docs.map((document) => _BuildMessageItem(document)).toList(),
        );
      },
    );
  }

  // BuildMessage item
  Widget _BuildMessageItem(DocumentSnapshot documentSnapshot) {
    Map<String ,dynamic> data = documentSnapshot.data() as Map<String, dynamic>;

    var alignment = data['senderId'] == _firebaseAuth.currentUser!.uid  ? Alignment.centerLeft : Alignment.centerRight;

    return Container(
      alignment: alignment,
      child: Column(
        children: [
          Text(data['senderEmail']),
          Text(data['message'])
        ],
      ),
    );
  }

  // user Input
  Widget _BuildMessageInput() {
    return Row(
      children: [
        // textFormField
        Expanded(
          child: MyTextFormField(
            controller: _messageController,
            hintText: 'send your message',
            obscureText: false,
          ),
        ),
        IconButton(
          onPressed: () => sendMessage(), 
          icon: const Icon(Icons.send, size: 40, color: Colors.red,),
        ),

      ],
    );
  }
}
