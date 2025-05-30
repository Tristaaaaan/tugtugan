import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tugtugan/features/chat/presentation/chat_provider.dart';

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
    final messagesAsync =
        ref.watch(chatMessagesStreamProvider((studioId, clientId)));

    return messagesAsync.when(
      data: (messages) {
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
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
