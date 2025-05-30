import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tugtugan/features/chat/application/send_message_use_case.dart';
import 'package:tugtugan/features/chat/data/chat_service.dart';
import 'package:tugtugan/features/chat/presentation/widget/chatbox.dart';
import 'package:tugtugan/features/chat/presentation/widget/chatscreen.dart';

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

    final sendMessage = SendMessageUseCase(ChatService());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: Column(
        children: [
          ChatScreen(
            studioId: studioId,
            clientId: auth.currentUser!.uid,
          ),
          ChatBox(
            messageController: messageController,
            studioId: studioId,
            auth: auth,
            sendMessage: sendMessage,
          ),
        ],
      ),
    );
  }
}
