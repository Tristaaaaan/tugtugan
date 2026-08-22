import 'dart:developer' as developer;
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../commons/widgets/buttons/loading_state_notifier.dart';
import '../../../../commons/widgets/buttons/regular_button.dart';
import '../../../../core/apptext/app_text.dart';
import '../../../book_appointment/domain/entities/appointment_entity.dart';
import '../../../book_appointment/domain/entities/appointment_slot_entity.dart';
import '../../../book_appointment/presentation/providers/appointment_providers.dart';
import '../../../book_appointment/presentation/screen/book_appointment.dart';
import '../../../reviews/presentation/widgets/add_review/write_review.dart';
import '../../../reviews/presentation/widgets/display_review/review_content.dart';
import '../../application/studio_use_case.dart';
import '../../data/repository/studio_repo_impl.dart';
import '../../domain/entities/studio_entity.dart';
import '../providers/studio_data_providers.dart';
import '../providers/studio_provider.dart';
import '../widget/studio_info_section.dart';

class Studio extends ConsumerStatefulWidget {
  final String studioId;
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
    final specificStudio = ref.watch(specificStudioProvider(widget.studioId));
    final studioService = StudioUseCase(StudioServices());
    final FirebaseAuth auth = FirebaseAuth.instance;
    final isBooking = ref.watch(isBookingModeProvider);
    // Listen to appointment state changes
    ref.listen(appointmentControllerProvider, (previous, next) {
      next.whenOrNull(
        success: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Appointment booked successfully!'),
              backgroundColor: Colors.green,
            ),
          );
          // Navigate away or reset
          ref.read(appointmentSelectionProvider.notifier).clear();
        },
        failure: (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error),
              backgroundColor: Colors.red,
            ),
          );
        },
        needsSignIn: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please sign in to book'),
              backgroundColor: Colors.orange,
            ),
          );
        },
      );
    });

    return Scaffold(
      body: specificStudio.when(
        data: (data) {
          final StudioEntity studio = data;
          final userId = auth.currentUser!.uid;
          final isFollowing = studio.followers.contains(userId);

          return SafeArea(
            child: CustomScrollView(
              slivers: [
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
                                  studioAvailability: studio.businessHours!,
                                  studioId: studio.id,
                                  studioName: studio.studioName,
                                  rating: 4.5,
                                  reviewCount: 12,
                                  onConfirm: () {
                                    developer.log(
                                        'Confirm booking for studio: ${studio.id}');
                                  },
                                )
                              : StudioInfoSection(
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
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RegularButton(
                        width: 200,
                        text: 'Continue',
                        backgroundColor:
                            Theme.of(context).colorScheme.primaryFixedDim,
                        textColor: Theme.of(context).colorScheme.surface,
                        buttonKey: "confirmBookingButton",
                        withIcon: false,
                        onTap: () async {
                          final List<AppointmentSlotEntity> slots =
                              ref.read(appointmentSelectionProvider).slots;
                          final appointment = AppointmentEntity(
                            studioId: widget.studioId,
                            customerId: FirebaseAuth.instance.currentUser!.uid,
                            slots: slots,
                          );
                          final isLoading =
                              ref.read(regularButtonLoadingProvider.notifier);

                          isLoading.setLoading("confirmBookingButton", true);
                          await ref
                              .read(appointmentControllerProvider.notifier)
                              .createAppointment(appointment);
                          isLoading.setLoading("confirmBookingButton", false);
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
