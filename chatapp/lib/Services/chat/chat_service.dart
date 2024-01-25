import 'package:chatapp/Models/Message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatService extends ChangeNotifier {
  //get instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //send message
  Future<void> sendMessage(String receverId, String message) async {
    //get current user information
    final String currentUserId = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    //create a new message
    Message newmessage = Message(
        senderId: currentUserId,
        senderEmail: currentUserEmail,
        receiverId: receverId,
        message: message,
        timestamp: timestamp);

    //construce the chat room id  from current user id and recever id
    List<String> ids = [currentUserId, receverId];

    ids.sort();
    String chatRoomId = ids.join("-");

    await _firestore
        .collection("chat_room")
        .doc(chatRoomId)
        .collection("Messages")
        .add(newmessage.toMap());

    //add new message to database
  }

  //get message
  Stream<QuerySnapshot> getMessage(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("-");
    return _firestore
        .collection("chat_room")
        .doc(chatRoomId)
        .collection("Messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
