import 'dart:developer' as developer;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tugtugan/commons/widgets/textfields/regular_textfield.dart';
import 'package:tugtugan/features/chat/application/send_message_use_case.dart';
import 'package:tugtugan/features/chat/domain/message_model.dart';

class ChatBox extends StatelessWidget {
  const ChatBox({
    super.key,
    required this.messageController,
    required this.studioId,
    required this.auth,
    required this.sendMessage,
  });

  final TextEditingController messageController;
  final String studioId;
  final FirebaseAuth auth;
  final SendMessageUseCase sendMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 25,
        right: 25,
        bottom: 15,
        top: 10,
      ),
      width: double.infinity,
      child: RegularTextField(
        controller: messageController,
        icon: Icons.add,
        hintText: "Type a message here",
        withTitle: false,
        withSuffixIcon: true,
        onSuffixIconPressed: () async {
          developer.log("Message sent: ${messageController.text}");

          final MessageModel message = MessageModel(
              messageId:
                  "$studioId${auth.currentUser!.uid}${Timestamp.now().millisecondsSinceEpoch}",
              message: messageController.text,
              timestamp: Timestamp.now(),
              type: "text",
              clientId: auth.currentUser!.uid,
              studioId: studioId);

          await sendMessage.execute(message);

          messageController.clear();
        },
      ),
    );
  }
}
