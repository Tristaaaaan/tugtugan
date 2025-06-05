import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tugtugan/core/appmodels/studio_model.dart';

import '../../chat/domain/studio_chat_model.dart';
import 'inbox_provider.dart';

class InboxPage extends ConsumerWidget {
  const InboxPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final inbox = ref.watch(studioInboxProvider(auth.currentUser!.uid));
    final state = ref.watch(realtimeInboxStateProvider(auth.currentUser!.uid));
    return SafeArea(
      child: Scaffold(
        body: inbox.when(
          data: (messages) {
            return CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index < state.inbox.length) {
                        final inbox = state.inbox[index];
                        return InboxBox(inbox: inbox, studio: messages[index]);
                      } else {
                        return const Padding(
                          padding: EdgeInsets.all(16),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                    },
                    childCount:
                        state.inbox.length + (state.hasMoreInbox ? 1 : 0),
                  ),
                ),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Text('Error: $error'),
        ),
      ),
    );
  }
}

class InboxBox extends StatelessWidget {
  final StudioChatModel inbox;
  final StudioModel studio;
  const InboxBox({
    super.key,
    required this.inbox,
    required this.studio,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go('/chat?studioId=${inbox.studioId}');
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 3),
        margin: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 25,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: CachedNetworkImage(
                      imageUrl: studio.imageUrl,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => const Icon(
                        Icons.broken_image,
                      ),
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey[400]!,
                        highlightColor: Colors.grey[300]!,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                          height: 150,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.5,
                      ),
                      child: IntrinsicHeight(
                        child: Text(
                          studio.studioName,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(inbox.lastMessage),
                  ],
                ),
              ],
            ),
            Text(
              DateFormat('hh:mm a').format(inbox.lastMessageTimeSent.toDate()),
            ),
          ],
        ),
      ),
    );
  }
}
