import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tugtugan/features/chat/domain/message_model.dart';

class ChatScreen extends ConsumerWidget {
  final List<MessageModel> messages;
  const ChatScreen({
    super.key,
    required this.messages,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: messages.isEmpty
          ? const Center(
              child: Text('No messages'),
            )
          : ListView.builder(
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return ListTile(
                  title: Text(
                    message.message,
                  ),
                );
              },
            ),
    );
  }
}
