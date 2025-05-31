import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tugtugan/features/chat/application/send_message_use_case.dart';
import 'package:tugtugan/features/chat/data/chat_service.dart';
import 'package:tugtugan/features/chat/presentation/chat_provider.dart';
import 'package:tugtugan/features/chat/presentation/widget/chatbox.dart';
import 'package:tugtugan/features/chat/presentation/widget/chatcontainer.dart';

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
            title: Text(messages.chat!.lastMessage),
          ),
          body: Column(
            children: [
              ChatScreen(
                messages: messages.messages,
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
