import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

Widget _buildDayCell(
  BuildContext context,
  DateTime day, {
  required List<DateTime> datesWithData,
  bool isSelected = false,
  bool isToday = false,
  bool isPast = false,
}) {
  return Container(
    margin: const EdgeInsets.all(1),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      border: isToday
          ? Border.all(
              color: Theme.of(context).colorScheme.primary,
              width: 2,
            )
          : null,
      color: isToday
          ? null
          : isSelected
              ? Theme.of(context).colorScheme.primary
              : Colors.transparent,
    ),
    child: Text(
      '${day.day}',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: isPast
            ? Colors.grey
            : isSelected
                ? Theme.of(context).colorScheme.surface
                : Theme.of(context).colorScheme.onSurface,
        decoration: isPast ? TextDecoration.lineThrough : TextDecoration.none,
        decorationColor: Colors.grey,
        decorationThickness: 2.5,
      ),
    ),
  );
}

class CalendarHeaderDelegate extends SliverPersistentHeaderDelegate {
  final DateTime currentFocusedMonth;
  final DateTime focusedDay;
  final List<DateTime> datesWithData;

  final VoidCallback onPreviousMonth;
  final VoidCallback onNextMonth;

  final ValueChanged<DateTime> onPageChanged;
  final ValueChanged<DateTime> onDaySelected;

  CalendarHeaderDelegate({
    required this.currentFocusedMonth,
    required this.focusedDay,
    required this.datesWithData,
    required this.onPreviousMonth,
    required this.onNextMonth,
    required this.onPageChanged,
    required this.onDaySelected,
  });

  @override
  double get minExtent => 400;

  @override
  double get maxExtent => 400;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final now = DateTime.now();

    // Remove the time portion.
    final today = DateTime(
      now.year,
      now.month,
      now.day,
    );

    // Current month.
    final currentMonth = DateTime(
      now.year,
      now.month,
    );

    // Month currently displayed.
    final displayedMonth = DateTime(
      currentFocusedMonth.year,
      currentFocusedMonth.month,
    );

    // User can only go backwards if they are after the current month.
    final canGoPrevious = displayedMonth.isAfter(currentMonth);

    return Material(
      elevation: overlapsContent ? 2 : 0,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          const SizedBox(height: 12),

          // Month navigation
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.chevron_left,
                ),
                onPressed: canGoPrevious ? onPreviousMonth : null,
              ),
              Text(
                DateFormat('MMMM yyyy').format(
                  currentFocusedMonth,
                ),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.chevron_right,
                ),
                onPressed: onNextMonth,
              ),
            ],
          ),

          // Calendar
          Column(
            children: [
              // Custom weekday header
              const Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        'M',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'T',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'W',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'T',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'F',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'S',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'S',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              TableCalendar(
                availableGestures: AvailableGestures.none,
                headerVisible: false,
                daysOfWeekVisible: false,
                firstDay: DateTime.utc(
                  2000,
                  1,
                  1,
                ),
                lastDay: DateTime.utc(
                  2030,
                  3,
                  14,
                ),
                focusedDay: focusedDay,
                enabledDayPredicate: (day) {
                  return !day.isBefore(today);
                },
                onPageChanged: onPageChanged,
                onDaySelected: (selectedDay, focusedDay) {
                  if (!selectedDay.isBefore(today)) {
                    onDaySelected(selectedDay);
                  }
                },
                calendarBuilders: CalendarBuilders(
                  defaultBuilder: (context, day, focusedDay) {
                    return _buildDayCell(
                      context,
                      day,
                      datesWithData: datesWithData,
                      isPast: day.isBefore(today),
                    );
                  },
                  disabledBuilder: (context, day, focusedDay) {
                    return _buildDayCell(
                      context,
                      day,
                      datesWithData: datesWithData,
                      isPast: true,
                    );
                  },
                  selectedBuilder: (context, day, focusedDay) {
                    return _buildDayCell(
                      context,
                      day,
                      datesWithData: datesWithData,
                      isSelected: true,
                      isPast: day.isBefore(today),
                    );
                  },
                  todayBuilder: (context, day, focusedDay) {
                    return _buildDayCell(
                      context,
                      day,
                      datesWithData: datesWithData,
                      isToday: true,
                    );
                  },
                ),
                selectedDayPredicate: (day) {
                  return isSameDay(
                    focusedDay,
                    day,
                  );
                },
                availableCalendarFormats: const {
                  CalendarFormat.month: 'Month',
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(
    covariant CalendarHeaderDelegate oldDelegate,
  ) {
    return oldDelegate.currentFocusedMonth != currentFocusedMonth ||
        oldDelegate.focusedDay != focusedDay ||
        oldDelegate.datesWithData != datesWithData;
  }
}
