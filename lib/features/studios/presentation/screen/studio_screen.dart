import 'dart:developer' as developer;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tugtugan/commons/widgets/buttons/regular_button.dart';
import 'package:tugtugan/commons/widgets/text/expandable_text.dart';
import 'package:tugtugan/core/appmodels/studio_model.dart';
import 'package:tugtugan/core/apptext/app_text.dart';
import 'package:tugtugan/features/studios/application/studio_use_case.dart';
import 'package:tugtugan/features/studios/data/studio_services.dart';
import 'package:tugtugan/features/studios/presentation/providers/studio_data_providers.dart';

import '../../../reviews/presentation/widgets/add_review/write_review.dart';
import '../../../reviews/presentation/widgets/display_review/review_content.dart';

class Studio extends ConsumerWidget {
  final String? studioId;
  const Studio({
    super.key,
    required this.studioId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final specificStudio = ref.watch(specificStudioProvider(studioId!));
    final studioService = StudioUseCase(StudioServices());
    final FirebaseAuth auth = FirebaseAuth.instance;
    return Scaffold(
      body: specificStudio.when(
        data: (data) {
          final StudioModel studio = data;
          final userId = auth.currentUser!.uid;
          final isFollowing = studio.followers.contains(userId);

          return SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    color: Theme.of(context)
                        .colorScheme
                        .surface, //), // 👈 Set custom color
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  expandedHeight: 430,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 400,
                          child: CachedNetworkImage(
                            imageUrl: studio.imageUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.broken_image),
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: Colors.grey[400]!,
                              highlightColor: Colors.grey[300]!,
                              child: Container(
                                width: double.infinity,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Theme.of(context).colorScheme.tertiary,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 425,
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              width: 60,
                              height: 60,
                              margin: const EdgeInsets.only(
                                right: 15,
                              ),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: GestureDetector(
                                onTap: () async {
                                  await studioService.execute(
                                    isFollowing,
                                    studio.id,
                                    userId,
                                  );
                                },
                                child: isFollowing
                                    ? const Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                      )
                                    : const Icon(
                                        Icons.favorite_border,
                                        color: Colors.grey,
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ConstrainedBox(
                                      constraints:
                                          const BoxConstraints(maxWidth: 250),
                                      child: Text(
                                        data.studioName,
                                        style: const TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ShaderMask(
                                          shaderCallback: (bounds) =>
                                              LinearGradient(
                                            colors: [
                                              Theme.of(context)
                                                  .colorScheme
                                                  .tertiaryContainer,
                                              Colors.amber
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ).createShader(bounds),
                                          blendMode: BlendMode.srcIn,
                                          child: const Icon(
                                            Icons.star,
                                            size: 16,
                                            color: Colors.amber,
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        const Text(
                                          "4.5 (12 reviews)",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    context.go(
                                        '/maps?name=${studio.studioName}&latitude=${studio.location.latitude}&longitude=${studio.location.longitude}');
                                    developer.log("Show map");
                                    developer.log(data.studioName);
                                    developer.log(
                                        "Longitude: ${studio.location.longitude}");
                                    developer.log(
                                        "Latitude: ${studio.location.latitude}");
                                  },
                                  child: Text(
                                    "Show map",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 10),
                            InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: () {
                                context.go('/chat?studioId=${studio.id}');
                                developer.log("Chat with studio: ${studio.id}");
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.message,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primaryFixedDim,
                                    ),
                                    const SizedBox(height: 4),
                                    const Text(
                                      "Chat",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: () async {
                                showReviewSheet(context, studio.id);
                                developer.log("Chat with studio: ${studio.id}");
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.message,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primaryFixedDim,
                                    ),
                                    const SizedBox(height: 4),
                                    const Text(
                                      "Review",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            ExpandableText(
                              text: studio.description,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: Divider(
                          thickness: .5,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ReviewContent(
                        studioId: studio.id,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        error: (error, stackTrace) => Text(error.toString()),
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      bottomNavigationBar: IntrinsicHeight(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "₱199/hr",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primaryFixedDim,
                ),
              ),
              RegularButton(
                width: 200,
                text: AppText.bookNow,
                backgroundColor: Theme.of(context).colorScheme.primaryFixedDim,
                textColor: Theme.of(context).colorScheme.surface,
                buttonKey: "bookButton",
                withIcon: false,
                onTap: () async {
                  final token =
                      await FirebaseAuth.instance.currentUser?.getIdToken();
                  developer.log("Token: $token");
                  context.push('/booking-payment');
                },
              ),
            ],
          ),
        ),
      ),
      // bottomSheet: Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: [
      //     Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      //       const Text(
      //         AppText.price,
      //         style: TextStyle(
      //           fontSize: 12,
      //           fontWeight: FontWeight.w500,
      //         ),
      //       ),
      //       Text(
      //         "\$199",
      //         style: TextStyle(
      //           fontSize: 24,
      //           fontWeight: FontWeight.bold,
      //           color: Theme.of(context).colorScheme.secondary,
      //         ),
      //       ),
      //     ]),
      //     RegularButton(
      //       text: AppText.bookNow,
      //       backgroundColor: Theme.of(context).colorScheme.primary,
      //       textColor: Theme.of(context).colorScheme.surface,
      //       buttonKey: "bookButton",
      //       withIcon: false,
      //     ),
      //   ],
      // ),
    );
  }
}
