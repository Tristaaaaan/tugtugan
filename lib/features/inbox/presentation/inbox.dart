import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tugtugan/features/inbox/presentation/widgets/inbox_container.dart';

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
                const SliverAppBar(
                  title: Text('Inbox'),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index < state.inbox.length) {
                        final inbox = state.inbox[index];
                        return InboxContainer(
                          inbox: inbox,
                          studio: messages[index],
                        );
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
