import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tugtugan/features/chat/presentation/chat_provider.dart';

import 'chatbubble.dart';

class ChatScreen extends ConsumerWidget {
  final String studioId;
  final String clientId;

  const ChatScreen({
    super.key,
    required this.studioId,
    required this.clientId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(realtimeChatStateProvider((studioId, clientId)));

    return Expanded(
      child: ListView.builder(
        reverse: true,
        controller: state.homeScrollController,
        itemCount: state.users.length + (state.hasNextUser ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < state.users.length) {
            final user = state.users[index];
            return ChatBubble(message: user);
          } else {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }
}
