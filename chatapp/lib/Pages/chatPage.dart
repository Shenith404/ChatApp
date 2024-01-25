import 'package:chatapp/Component/colors.dart';
import 'package:chatapp/Component/messageBuble.dart';
import 'package:chatapp/Component/my_text_field.dart';
import 'package:chatapp/Pages/loading.dart';
import 'package:chatapp/Services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String receverUserEmail;
  final String receverUserId;
  const ChatPage(
      {super.key, required this.receverUserEmail, required this.receverUserId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController messageController = TextEditingController();
  final ChatService chatService = ChatService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  final ScrollController _scrollController = ScrollController();

  // send message
  void sendMessage() async {
    if (messageController.text.isNotEmpty) {
      await chatService.sendMessage(
          widget.receverUserId, messageController.text);
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.defaultColor,
        title: Text(widget.receverUserEmail),
      ),
      body: Column(
        children: [
          //message
          Expanded(
            child: _buildMessageList(),
          ),
          // user input
          _buildMessageInput(),
        ],
      ),
    );
  }

  //build message list
  Widget _buildMessageList() {
    return StreamBuilder(
      stream:
          chatService.getMessage(widget.receverUserId, _auth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Error ${snapshot.error.toString()}");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loading();
        }
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        });

        return ListView(
          controller: _scrollController,
          children: snapshot.data!.docs
              .map((document) => _buildMessageItem(document))
              .toList(),
        );
      },
    );
  }

  //build message item
  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    debugPrint(data.toString());

    //aligmnet of message
    var allignment = (data["senderID"] == _auth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    //change the colour of  chat buble
    var bubleColour = (data["senderID"] == _auth.currentUser!.uid)
        ? MyColors.defaultColor2
        : MyColors.defaultColor3;
    return Container(
        alignment: allignment,
        child: Column(
          children: [
            MessageBuble(message: data['message'], color: bubleColour,margin: 1,),
          ],
        ));
  }

  //build message input

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: MyTextfield(
              contraller: messageController,
              hintText: "Write a new message",
              obscureText: false,
            ),
          ),
          //send btn
          Padding(
            padding: const EdgeInsets.only(bottom: 10, right: 12),
            child: IconButton(
                onPressed: sendMessage,
                icon: const Icon(
                  Icons.send,
                  size: 40,
                  color: MyColors.defaultColor,
                )),
          )
        ],
      ),
    );
  }
}
