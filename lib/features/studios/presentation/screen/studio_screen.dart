import 'dart:developer' as developer;
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tugtugan/commons/widgets/buttons/regular_button.dart';
import 'package:tugtugan/commons/widgets/text/expandable_text.dart';
import 'package:tugtugan/core/appmodels/studio_model.dart';
import 'package:tugtugan/core/apptext/app_text.dart';
import 'package:tugtugan/features/book_appointment/presentation/screen/book_appointment.dart';
import 'package:tugtugan/features/reviews/presentation/widgets/add_review/write_review.dart';
import 'package:tugtugan/features/reviews/presentation/widgets/display_review/review_content.dart';
import 'package:tugtugan/features/studios/application/studio_use_case.dart';
import 'package:tugtugan/features/studios/data/studio_services.dart';
import 'package:tugtugan/features/studios/presentation/providers/studio_data_providers.dart';

// TODO: point these at your actual project paths
// import '../providers/specific_studio_provider.dart';
// import '../models/studio_model.dart';
// import '../use_cases/studio_use_case.dart';
// import '../services/studio_services.dart';
// import '../widgets/expandable_text.dart';
// import '../widgets/review_content.dart';
// import '../widgets/regular_button.dart';
// import '../constants/app_text.dart';
// import '../widgets/review_sheet.dart' show showReviewSheet;

/// True once the Reserve button has been tapped and the screen has
/// morphed into the embedded booking UI. Drives both the header
/// collapse animation and the content cross-fade.
final isBookingModeProvider = StateProvider<bool>((ref) => false);

class Studio extends ConsumerStatefulWidget {
  final String? studioId;
  const Studio({
    super.key,
    required this.studioId,
  });

  @override
  ConsumerState<Studio> createState() => _StudioState();
}

class _StudioState extends ConsumerState<Studio>
    with SingleTickerProviderStateMixin {
  static const double _fullHeaderHeight = 430;
  static const double _collapsedHeaderHeight = 160;

  late final AnimationController _bookingController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 400),
  );

  void _toggleBooking(bool goToBooking) {
    ref.read(isBookingModeProvider.notifier).state = goToBooking;
    if (goToBooking) {
      _bookingController.forward();
    } else {
      _bookingController.reverse();
    }
  }

  @override
  void dispose() {
    _bookingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final specificStudio = ref.watch(specificStudioProvider(widget.studioId!));
    final studioService = StudioUseCase(StudioServices());
    final FirebaseAuth auth = FirebaseAuth.instance;
    final isBooking = ref.watch(isBookingModeProvider);

    return Scaffold(
      body: specificStudio.when(
        data: (data) {
          final StudioModel studio = data;
          final userId = auth.currentUser!.uid;
          final isFollowing = studio.followers.contains(userId);

          return SafeArea(
            child: CustomScrollView(
              slivers: [
                // --- Header: animates between full (430) and collapsed (160) ---
                AnimatedBuilder(
                  animation: _bookingController,
                  builder: (context, _) {
                    final t = _bookingController.value;
                    final height = lerpDouble(
                      _fullHeaderHeight,
                      _collapsedHeaderHeight,
                      t,
                    )!;

                    return SliverPersistentHeader(
                      pinned: false,
                      delegate: StudioHeaderDelegate(
                        height: height,
                        imageUrl: studio.imageUrl,
                        // Fade + shrink the follow button as we collapse
                        actionOpacity: 1 - t,
                        onBack: () {
                          if (isBooking) {
                            _toggleBooking(false);
                          } else {
                            Navigator.of(context).pop();
                          }
                        },
                        showFollowButton: t < 0.5,
                        isFollowing: isFollowing,
                        onFollowTap: () async {
                          await studioService.execute(
                            isFollowing,
                            studio.id,
                            userId,
                          );
                        },
                      ),
                    );
                  },
                ),

                // --- Body: cross-fades between studio info and booking UI ---
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          switchInCurve: Curves.easeOut,
                          switchOutCurve: Curves.easeIn,
                          transitionBuilder: (child, animation) {
                            final offsetAnimation = Tween<Offset>(
                              begin: const Offset(0, 0.05),
                              end: Offset.zero,
                            ).animate(animation);
                            return FadeTransition(
                              opacity: animation,
                              child: SlideTransition(
                                position: offsetAnimation,
                                child: child,
                              ),
                            );
                          },
                          child: isBooking
                              ? EmbeddedBookingSection(
                                  key: const ValueKey('booking'),
                                  studioId: studio.id,
                                  studioName: studio.studioName,
                                  // TODO: swap in the real fields once
                                  // rating/reviewCount live on StudioModel
                                  rating: 4.5,
                                  reviewCount: 12,
                                  onConfirm: () {
                                    // TODO: hook up your booking confirmation flow
                                    developer.log(
                                        'Confirm booking for studio: ${studio.id}');
                                  },
                                )
                              : _StudioInfoSection(
                                  key: const ValueKey('info'),
                                  studio: studio,
                                  onShowMap: () {
                                    context.go(
                                        '/maps?name=${studio.studioName}&latitude=${studio.location.latitude}&longitude=${studio.location.longitude}');
                                    developer.log("Show map");
                                  },
                                  onChat: () {
                                    context.go('/chat?studioId=${studio.id}');
                                    developer
                                        .log("Chat with studio: ${studio.id}");
                                  },
                                  onReview: () {
                                    showReviewSheet(context, studio.id);
                                  },
                                ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      if (!isBooking) ...[
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25),
                          child: Divider(thickness: .5),
                        ),
                        const SizedBox(height: 10),
                        ReviewContent(studioId: studio.id),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        error: (error, stackTrace) => Text(error.toString()),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
      bottomNavigationBar: IntrinsicHeight(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
          ),
          child: isBooking
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => _toggleBooking(false),
                      child: const Text('Back'),
                    ),
                    RegularButton(
                        width: 200,
                        text: 'Continue',
                        backgroundColor:
                            Theme.of(context).colorScheme.primaryFixedDim,
                        textColor: Theme.of(context).colorScheme.surface,
                        buttonKey: "confirmBookingButton",
                        withIcon: false,
                        onTap: () async {
                          final user = FirebaseAuth.instance.currentUser;

                          // 1. Check if user is signed in
                          if (user == null) {
                            developer.log("User is not signed in.");
                            // Redirect user to login screen here
                            return;
                          }

                          try {
                            // 2. Force token refresh if session expired
                            await user.getIdToken(true);

                            final functions = FirebaseFunctions.instanceFor(
                              region: 'us-central1',
                            );

                            final callable =
                                functions.httpsCallable('create_appointment');

                            final result = await callable.call({
                              'date': '2026-08-20',
                            });

                            print(result.data);
                          } on FirebaseFunctionsException catch (e) {
                            developer.log(
                                "Cloud Function Error: ${e.code} - ${e.message}");
                          } catch (e) {
                            developer.log("Error: $e");
                          }
                        }),
                  ],
                )
              : Row(
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
                      text: AppText.reserve,
                      backgroundColor:
                          Theme.of(context).colorScheme.primaryFixedDim,
                      textColor: Theme.of(context).colorScheme.surface,
                      buttonKey: "bookButton",
                      withIcon: false,
                      onTap: () {
                        developer.log("Enter booking mode (in place)");
                        _toggleBooking(true);
                      },
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

/// The studio's name/rating/chat/review/description block.
/// Extracted so it can be cross-faded with [EmbeddedBookingSection].
class _StudioInfoSection extends StatelessWidget {
  final StudioModel studio;
  final VoidCallback onShowMap;
  final VoidCallback onChat;
  final VoidCallback onReview;

  const _StudioInfoSection({
    super.key,
    required this.studio,
    required this.onShowMap,
    required this.onChat,
    required this.onReview,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  constraints: const BoxConstraints(maxWidth: 250),
                  child: Text(
                    studio.studioName,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.tertiaryContainer,
                          Colors.amber,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds),
                      blendMode: BlendMode.srcIn,
                      child:
                          const Icon(Icons.star, size: 16, color: Colors.amber),
                    ),
                    const SizedBox(width: 5),
                    const Text("4.5 (12 reviews)",
                        style: TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
            GestureDetector(
              onTap: onShowMap,
              child: Text(
                "Show map",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onChat,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Column(
              children: [
                Icon(Icons.message,
                    color: Theme.of(context).colorScheme.primaryFixedDim),
                const SizedBox(height: 4),
                const Text("Message", style: TextStyle(fontSize: 14)),
              ],
            ),
          ),
        ),
        // InkWell(
        //   borderRadius: BorderRadius.circular(8),
        //   onTap: onReview,
        //   child: Container(
        //     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        //     child: Column(
        //       children: [
        //         Icon(Icons.message,
        //             color: Theme.of(context).colorScheme.primaryFixedDim),
        //         const SizedBox(height: 4),
        //         const Text("Review", style: TextStyle(fontSize: 14)),
        //       ],
        //     ),
        //   ),
        // ),
        const SizedBox(height: 10),
        ExpandableText(text: studio.description),
      ],
    );
  }
}

/// Sliver header that animates its own extent between a full hero image
/// (430) and a collapsed strip (160), and fades the follow button out
/// as it shrinks. Replaces the old static SliverAppBar.
class StudioHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double height;
  final String imageUrl;
  final double actionOpacity;
  final bool showFollowButton;
  final bool isFollowing;
  final VoidCallback onBack;
  final VoidCallback onFollowTap;

  StudioHeaderDelegate({
    required this.height,
    required this.imageUrl,
    required this.actionOpacity,
    required this.showFollowButton,
    required this.isFollowing,
    required this.onBack,
    required this.onFollowTap,
  });

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          errorWidget: (context, url, error) => const Icon(Icons.broken_image),
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
        Positioned(
          top: 8,
          left: 8,
          child: SafeArea(
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Theme.of(context).colorScheme.surface,
              onPressed: onBack,
            ),
          ),
        ),
        if (showFollowButton)
          Positioned(
            right: 15,
            bottom: 15,
            child: Opacity(
              opacity: actionOpacity.clamp(0.0, 1.0),
              child: Container(
                width: 60,
                height: 60,
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
                  onTap: onFollowTap,
                  child: isFollowing
                      ? const Icon(Icons.favorite, color: Colors.red)
                      : const Icon(Icons.favorite_border, color: Colors.grey),
                ),
              ),
            ),
          ),
      ],
    );
  }

  @override
  bool shouldRebuild(covariant StudioHeaderDelegate oldDelegate) {
    return oldDelegate.height != height ||
        oldDelegate.imageUrl != imageUrl ||
        oldDelegate.actionOpacity != actionOpacity ||
        oldDelegate.showFollowButton != showFollowButton ||
        oldDelegate.isFollowing != isFollowing;
  }
}
