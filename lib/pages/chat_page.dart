import 'package:chat_app_2/components/chat_bubble.dart';
import 'package:chat_app_2/components/my_textfield.dart';
import 'package:chat_app_2/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserID;

  const ChatPage(
      {super.key,
      required this.receiverUserEmail,
      required this.receiverUserID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverUserID, _messageController.text);
    }
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverUserEmail),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getMessages(
          widget.receiverUserID, _firebaseAuth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }
        return ListView(
          children: snapshot.data!.docs
              .map<Widget>((doc) => _buildUserListItem(doc))
              .toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    var alignment = (data["senderId"] == _firebaseAuth.currentUser!.uid
        ? Alignment.centerRight
        : Alignment.centerLeft);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      alignment: alignment,
      child: Column(
        crossAxisAlignment: alignment == Alignment.centerRight
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Text(data["senderEmail"]),
          // Container(
          //   width: MediaQuery.of(context).size.width * 0.3,
          //   child: Text(
          //     data["message"],
          //   ),
          // ),
          const SizedBox(height: 5),
          ChatBubble(
            message: data['message'],
            color: alignment == Alignment.centerRight
                ? Colors.blue
                : Colors.grey,
          )
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: MediaQuery.of(context).size.width * 0.8,
            child: MyTextField(
              controller: _messageController,
              hintText: "Type a message",
              obscureText: false,
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: () {
              sendMessage();
            },
            icon: const Icon(Icons.arrow_upward),
          ),
        ],
      ),
    );
  }
}
