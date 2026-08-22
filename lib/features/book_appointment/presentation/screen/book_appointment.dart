import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../studios/presentation/providers/studio_provider.dart';
import '../widget/calendar.dart';
import '../widget/time_slots_container.dart';

final focusedDayProvider = StateProvider<DateTime>((ref) {
  return DateTime.now(); // Default: today
});

final focusedMonthProvider = StateProvider<DateTime>((ref) {
  return DateTime.now();
});

// This returns a DateTime instead of String
DateTime parseGroupDate(String originalDate) {
  final parts = originalDate.split('-');
  final month = int.parse(parts[0]);
  final day = int.parse(parts[1]);
  final year = int.parse(parts[2]);

  return DateTime(year, month, day, DateTime.now().hour, DateTime.now().minute,
      DateTime.now().second, DateTime.now().microsecond);
}

// Helper function to format the date string
String formatDateDisplay(String dateString) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = today.subtract(const Duration(days: 1));

  final parts = dateString.split('-');
  final date = DateTime(
    int.parse(parts[2]), // year
    int.parse(parts[0]), // month
    int.parse(parts[1]), // day
  );

  if (date == today) {
    return 'Today';
  } else if (date == yesterday) {
    return 'Yesterday';
  } else {
    return DateFormat('MMM d, y').format(date);
  }
}

void _navigateToMonth(WidgetRef ref, int monthOffset) {
  final currentFocusedDay = ref.read(focusedDayProvider);
  final newFocusedDay = DateTime(
    currentFocusedDay.year,
    currentFocusedDay.month + monthOffset,
    1,
  );
  ref.read(focusedDayProvider.notifier).state = newFocusedDay;
}

/// The calendar + time-slot grid, extracted from the old
/// `BookAppointmentScreen`. No `Scaffold`, no own `FloatingActionButton`,
/// no own route — it's a plain widget meant to be dropped straight into
/// the Studio screen's sliver body once booking mode is active.
class EmbeddedBookingSection extends ConsumerStatefulWidget {
  final String studioId;
  final String studioName;
  final double rating;
  final int reviewCount;
  final VoidCallback? onConfirm;

  const EmbeddedBookingSection({
    super.key,
    required this.studioId,
    required this.studioName,
    this.rating = 0,
    this.reviewCount = 0,
    this.onConfirm,
  });

  @override
  ConsumerState<EmbeddedBookingSection> createState() =>
      _EmbeddedBookingSectionState();
}

class _EmbeddedBookingSectionState
    extends ConsumerState<EmbeddedBookingSection> {
  final ScrollController _scrollController = ScrollController();

  // Multiple time slots can be picked for the same day
  // (e.g. "August 26, 8:00AM, 9:00, 12:00PM").
  bool _showScrollToTop = false;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      final shouldShow = _scrollController.hasClients &&
          _scrollController.position.maxScrollExtent > 0 &&
          _scrollController.offset > 50;

      if (_showScrollToTop != shouldShow) {
        setState(() {
          _showScrollToTop = shouldShow;
        });
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
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final focusedDay = ref.watch(focusedDayProvider);
    final currentFocusedMonth = ref.watch(focusedMonthProvider);
    final selectedMonthStudioAvailability = ref.watch(
      studioAvailabilityControllerProvider(
        GetStudioAvailabilityParams(
          studioId: widget.studioId,
          month: currentFocusedMonth.month,
          year: currentFocusedMonth.year,
        ),
      ),
    );
    List<DateTime> datesWithData = [];

    // Fixed height, non-Scaffold layout — sits directly inside the
    // Studio screen's sliver body instead of owning its own screen.
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Studio name + rating
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.studioName,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 6),
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
                        child: const Icon(Icons.star,
                            size: 14, color: Colors.amber),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${widget.rating.toStringAsFixed(1)} (${widget.reviewCount} reviews)',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Live-updating selected date + time(s) summary
            // AnimatedSwitcher(
            //   duration: const Duration(milliseconds: 200),
            //   child: Text(
            //     _buildSelectionSummary(focusedDay),
            //     key: ValueKey(_buildSelectionSummary(focusedDay)),
            //     style: TextStyle(
            //       fontSize: 14,
            //       fontWeight: FontWeight.w500,
            //       color: selectedTimes.isEmpty
            //           ? Colors.grey
            //           : Theme.of(context).colorScheme.primary,
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 375,
              child: selectedMonthStudioAvailability.when(
                initial: () => const Center(child: CircularProgressIndicator()),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e) => Center(child: Text(e.toString())),
                loaded: (data) {
                  developer.log("Data: $data");
                  return CalendarHeaderView(
                    currentFocusedMonth: currentFocusedMonth,
                    focusedDay: focusedDay,
                    datesWithData: datesWithData,
                    availabilityData: data,
                    onPreviousMonth: () => _navigateToMonth(ref, -1),
                    onNextMonth: () => _navigateToMonth(ref, 1),
                    onPageChanged: (focusedMonth) {
                      ref.read(focusedMonthProvider.notifier).state =
                          focusedMonth;
                    },
                    onDaySelected: (selectedDay) {
                      ref.read(focusedDayProvider.notifier).state = selectedDay;
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            const Text("Choose a time slot",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                )),
            const SizedBox(height: 4),

            // Get Business Hours

            TimeSlotsContainer(
                scrollController: _scrollController, studioId: widget.studioId),
          ],
        ),
        Positioned(
          right: 8,
          bottom: 8,
          child: AnimatedOpacity(
            opacity: _showScrollToTop ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: IgnorePointer(
              ignoring: !_showScrollToTop,
              child: FloatingActionButton(
                mini: true,
                elevation: 0,
                heroTag: 'scrollToTopBooking',
                shape: const CircleBorder(),
                backgroundColor: Theme.of(context)
                    .colorScheme
                    .primary
                    .withValues(alpha: 0.5),
                onPressed: _scrollToTop,
                child: Icon(
                  Icons.keyboard_arrow_up,
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

enum Availability { available, occupied }
