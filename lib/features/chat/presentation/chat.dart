import 'dart:developer' as developer;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tugtugan/commons/widgets/textfields/regular_textfield.dart';
import 'package:tugtugan/core/appmodels/conversation_model.dart';
import 'package:tugtugan/features/chat/chat_services.dart';

class ChatPage extends ConsumerWidget {
  final String studioId;
  const ChatPage({
    super.key,
    required this.studioId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final TextEditingController messageController = TextEditingController();
    final ChatServices chatServices = ChatServices();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: Column(
        children: [
          const Expanded(
            child: Text("This is the chat page"),
          ),
          Container(
            padding: const EdgeInsets.all(25),
            width: double.infinity,
            child: RegularTextField(
              controller: messageController,
              icon: Icons.add,
              hintText: "Type a message here",
              withTitle: false,
              withSuffixIcon: true,
              onSuffixIconPressed: () async {
                developer.log("Message sent: ${messageController.text}");

                // add the message to the db first
                final MessageModel message = MessageModel(
                    messageId:
                        "$studioId${auth.currentUser!.uid}${Timestamp.now().millisecondsSinceEpoch}",
                    message: messageController.text,
                    timestamp: Timestamp.now(),
                    type: "text",
                    clientId: auth.currentUser!.uid,
                    studioId: studioId);

                await chatServices.addMessage(message);

                messageController.clear();
              },
            ),
          ),
        ],
      ),
    );
  }
}
