import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tugtugan/features/inbox/data/chat_service.dart';

import '../../../../commons/widgets/avatars/avatar_placeholder.dart';
import '../../../../core/appmodels/studio_model.dart';
import '../../../chat/domain/studio_chat_model.dart';

class InboxContainer extends StatelessWidget {
  final StudioChatModel inbox;
  final StudioModel studio;
  const InboxContainer({
    super.key,
    required this.inbox,
    required this.studio,
  });

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final InboxService inboxService = InboxService();
    return GestureDetector(
      onTap: () {
        inboxService.updateLastReadMessage(
          studio.id,
          inbox.clientId,
          inbox.lastMessageId!,
        );
        if (context.mounted) {
          context.go('/chat?studioId=${inbox.studioId}');
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        margin: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        decoration: BoxDecoration(
          color: inbox.members![auth.currentUser!.uid]?.lastMessageIdRead ==
                  inbox.lastMessageId
              ? Theme.of(context).colorScheme.surface
              : Theme.of(context).colorScheme.tertiary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
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
                    child: studio.imageUrl.isEmpty
                        ? UserAvatarPlaceHolder(name: studio.studioName)
                        : CachedNetworkImage(
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
