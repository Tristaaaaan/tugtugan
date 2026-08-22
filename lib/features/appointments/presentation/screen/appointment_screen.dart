import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tugtugan/core/apptext/app_text.dart';
import 'package:tugtugan/features/appointments/presentation/enums/top_selection_bar_enum.dart';
import 'package:tugtugan/features/appointments/presentation/providers/user_appointments_providers.dart';
import 'package:tugtugan/features/appointments/presentation/widget/appointment_container.dart';
import 'package:tugtugan/features/appointments/presentation/widget/top_selection_bar.dart';

class AppointmentScreen extends ConsumerStatefulWidget {
  const AppointmentScreen({super.key});

  @override
  ConsumerState<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends ConsumerState<AppointmentScreen> {
  final ScrollController _scrollController = ScrollController();

  bool _showScrollToTop = false;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      // ✅ Scroll to top indicator
      final shouldShow = _scrollController.offset > 300;
      if (shouldShow != _showScrollToTop) {
        setState(() {
          _showScrollToTop = shouldShow;
        });
      }

      // ✅ Load more trigger - when user scrolls near bottom
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 500) {
        ref.read(userAppointmentsControllerProvider.notifier).loadMore();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isActiveAppoinmentTab = ref.watch(isActiveAppoinmentTabProvider);
    final appointmentsState = ref.watch(userAppointmentsControllerProvider);

    return SafeArea(
      child: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                pinned: true,
                backgroundColor: Theme.of(context).colorScheme.surface,
                surfaceTintColor: Colors.transparent,
                scrolledUnderElevation: 0,
                title: const Text(AppText.myAppointments),
              ),
              SliverToBoxAdapter(
                child: TopSelectionBar(
                  selectedTab: isActiveAppoinmentTab
                      ? ActiveAppointmentSelectionBar.active
                      : ActiveAppointmentSelectionBar.past,
                  onTabSelected: (tab) {
                    ref.read(isActiveAppoinmentTabProvider.notifier).state =
                        tab == ActiveAppointmentSelectionBar.active;
                  },
                ),
              ),
              // ✅ Handle different appointment states
              appointmentsState.when(
                initial: () => const SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                ),
                loading: () => const SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                ),
                loaded: (appointments, hasMore) {
                  return SliverToBoxAdapter(
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount:
                              appointments?.length ?? 0 + (hasMore ? 1 : 0),
                          itemBuilder: (context, index) {
                            // ✅ Show loading indicator at bottom if more items to load
                            if (index == appointments?.length) {
                              return const Padding(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                              );
                            }

                            final appointment = appointments![index];
                            return AppointmentContainer(
                              appointment: appointment,
                            )
                                .animate(delay: (index * 40).ms)
                                .fadeIn(
                                  duration: 1000.ms,
                                  curve: Curves.easeOut,
                                )
                                .slideY(
                                  begin: 0.15,
                                  end: 0,
                                  duration: 350.ms,
                                  curve: Curves.easeOutCubic,
                                );
                          },
                        ),
                      ],
                    ),
                  );
                },
                empty: () => SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            size: 64,
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withValues(alpha: 0.3),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No appointments found',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                error: (message) => SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 64,
                            color: Theme.of(context).colorScheme.error,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Error: $message',
                            style: Theme.of(context).textTheme.bodyMedium,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              ref
                                  .read(userAppointmentsControllerProvider
                                      .notifier)
                                  .fetchInitial();
                            },
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // ✅ Scroll to top FAB
          Positioned(
            bottom: 100,
            right: 12,
            child: AnimatedOpacity(
              opacity: _showScrollToTop ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: IgnorePointer(
                ignoring: !_showScrollToTop,
                child: FloatingActionButton(
                  mini: true,
                  elevation: 0,
                  heroTag: 'activities_fab',
                  shape: const CircleBorder(),
                  backgroundColor: Theme.of(
                    context,
                  ).colorScheme.primary.withValues(alpha: 0.5),
                  child: Icon(
                    Icons.arrow_upward_outlined,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  onPressed: () {
                    if (_scrollController.hasClients) {
                      _scrollController.animateTo(
                        0,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeOut,
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
