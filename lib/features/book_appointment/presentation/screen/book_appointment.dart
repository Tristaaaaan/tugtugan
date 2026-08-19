import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../data/datasource/local/local_datasource.dart';
import '../utils/availability_color.dart';
import '../widget/calendar.dart';

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
  final Set<AppointmentTime> selectedTimes = {};
  bool _showScrollToTop = false;

  void _toggleSlot(AppointmentTime slot) {
    setState(() {
      if (selectedTimes.contains(slot)) {
        selectedTimes.remove(slot);
      } else {
        selectedTimes.add(slot);
      }
    });
  }

  /// "August 26, 8:00AM, 9:00, 12:00PM"
  String _buildSelectionSummary(DateTime focusedDay) {
    if (selectedTimes.isEmpty) return 'No time selected yet';

    final datePart = DateFormat('MMMM d').format(focusedDay);

    // Keep display order matching dummyTimes rather than Set insertion order
    final orderedTimes = dummyTimes
        .where((t) => selectedTimes.contains(t))
        .map((t) => t.time)
        .join(', ');

    return '$datePart, $orderedTimes';
  }

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
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Text(
                _buildSelectionSummary(focusedDay),
                key: ValueKey(_buildSelectionSummary(focusedDay)),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: selectedTimes.isEmpty
                      ? Colors.grey
                      : Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            SizedBox(
              height: 350,
              child: CustomScrollView(
                physics: const NeverScrollableScrollPhysics(),
                slivers: [
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: CalendarHeaderDelegate(
                      currentFocusedMonth: currentFocusedMonth,
                      focusedDay: focusedDay,
                      datesWithData: datesWithData,
                      onPreviousMonth: () => _navigateToMonth(ref, -1),
                      onNextMonth: () => _navigateToMonth(ref, 1),
                      onPageChanged: (focusedMonth) {
                        ref.read(focusedMonthProvider.notifier).state =
                            focusedMonth;
                      },
                      onDaySelected: (selectedDay) {
                        ref.read(focusedDayProvider.notifier).state =
                            selectedDay;
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const Text("Choose a time slot",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                )),
            const SizedBox(height: 4),

            SizedBox(
              // Bounded height since this now lives inside another
              // scroll view (the Studio screen's CustomScrollView)
              // rather than owning the viewport itself.
              height: 400,
              child: ScrollbarTheme(
                data: ScrollbarThemeData(
                  thumbColor: WidgetStateProperty.all(
                    Theme.of(context).colorScheme.primary,
                  ),
                  trackColor: WidgetStateProperty.all(
                    Theme.of(context)
                        .colorScheme
                        .primary
                        .withValues(alpha: 0.15),
                  ),
                ),
                child: Scrollbar(
                  thumbVisibility: true,
                  controller: _scrollController,
                  child: GridView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.only(bottom: 100, right: 10),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 2.5,
                    ),
                    itemCount: dummyTimes.length,
                    itemBuilder: (context, index) {
                      final slot = dummyTimes[index];

                      final isAvailable =
                          slot.availability != Availability.occupied;

                      final statusText = switch (slot.availability) {
                        Availability.available => 'Available',
                        Availability.occupied => 'Occupied',
                      };

                      final isSelected = selectedTimes.contains(slot);

                      return GestureDetector(
                        onTap: isAvailable ? () => _toggleSlot(slot) : null,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border(
                              bottom: BorderSide(
                                color: isSelected
                                    ? Theme.of(context).colorScheme.primary
                                    : getAvailabilityColor(slot.availability),
                                width: .3,
                              ),
                              left: BorderSide(
                                color: isSelected
                                    ? Theme.of(context).colorScheme.primary
                                    : getAvailabilityColor(slot.availability),
                                width: 3,
                              ),
                            ),
                            color: isSelected
                                ? Theme.of(context).colorScheme.primary
                                : null,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                isSelected
                                    ? Icons.check_circle
                                    : Icons.access_time,
                                color: isSelected
                                    ? Theme.of(context).colorScheme.surface
                                    : Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withValues(alpha: 0.5),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      slot.time,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: !isAvailable
                                            ? Colors.grey
                                            : isSelected
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .surface
                                                : null,
                                      ),
                                    ),
                                    Text(
                                      statusText,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: isSelected
                                            ? Theme.of(context)
                                                .colorScheme
                                                .surface
                                            : getAvailabilityColor(
                                                slot.availability),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                          .animate(delay: (index * 40).ms)
                          .fadeIn(duration: 1000.ms, curve: Curves.easeOut)
                          .slideY(
                            begin: 0.15,
                            end: 0,
                            duration: 350.ms,
                            curve: Curves.easeOutCubic,
                          );
                    },
                  ),
                ),
              ),
            ),
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
