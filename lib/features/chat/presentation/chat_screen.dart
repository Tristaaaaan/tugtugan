import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/send_message_use_case.dart';
import '../data/chat_service.dart';
import 'chat_provider.dart';
import 'widget/chatbox.dart';
import 'widget/chatcontainer.dart';

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
    final conversations =
        ref.watch(combinedChatProvider((studioId, auth.currentUser!.uid)));
    final sendMessage = SendMessageUseCase(ChatService());

    return conversations.when(
      data: (messages) {
        return Scaffold(
          appBar: AppBar(
            title: Text(messages.studio?.studioName ?? 'Unknown Studio'),
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
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
