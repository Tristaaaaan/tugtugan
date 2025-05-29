import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tugtugan/commons/widgets/textfields/regular_textfield.dart';

class ChatPage extends ConsumerWidget {
  final String studioId;
  const ChatPage({
    super.key,
    required this.studioId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController messageController = TextEditingController();
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
              onSuffixIconPressed: () {
                developer.log("Message sent: ${messageController.text}");
                messageController.clear();
              },
            ),
          ),
        ],
      ),
    );
  }
}
