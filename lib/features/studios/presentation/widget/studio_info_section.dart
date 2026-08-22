import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../commons/widgets/text/expandable_text.dart';
import '../../domain/entities/studio_entity.dart';

class StudioInfoSection extends StatelessWidget {
  final StudioEntity studio;
  final VoidCallback onShowMap;
  final VoidCallback onChat;
  final VoidCallback onReview;

  const StudioInfoSection({
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

class StudioHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double height;
  final List<String> imageUrl;
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
          imageUrl: imageUrl.first,
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
