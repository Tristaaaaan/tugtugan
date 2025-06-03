import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tugtugan/features/chat/domain/message_model.dart';

class ChatBubble extends StatelessWidget {
  final MessageModel message;
  // final StudioModel studio;
  const ChatBubble({
    super.key,
    required this.message,
    // required this.studio,
  });

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 24,
          vertical: message.senderId != auth.currentUser!.uid ? 8 : 4,
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(
              //   width: 50,
              //   height: 50,
              //   child: ClipRRect(
              //     borderRadius: BorderRadius.circular(50),
              //     child: CachedNetworkImage(
              //       imageUrl: studio.imageUrl,
              //       fit: BoxFit.cover,
              //       errorWidget: (context, url, error) => const Icon(
              //         Icons.broken_image,
              //       ),
              //       placeholder: (context, url) => Shimmer.fromColors(
              //         baseColor: Colors.grey[400]!,
              //         highlightColor: Colors.grey[300]!,
              //         child: Container(
              //           width: double.infinity,
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(5),
              //             color: Theme.of(context).colorScheme.tertiary,
              //           ),
              //           height: 150,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              const SizedBox(width: 8),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(24),
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                    ),
                  ),
                  child: Text(
                    message.message,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    softWrap: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
