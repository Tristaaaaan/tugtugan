import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tugtugan/features/studios/domain/entities/availability_entity.dart';

class CalendarHeaderView extends StatelessWidget {
  final DateTime currentFocusedMonth;
  final DateTime focusedDay;
  final List<DateTime> datesWithData;
  final List<StudioAvailabilityEntity> availabilityData;
  final VoidCallback onPreviousMonth;
  final VoidCallback onNextMonth;

  final ValueChanged<DateTime> onPageChanged;
  final ValueChanged<DateTime> onDaySelected;

  const CalendarHeaderView({
    super.key,
    required this.currentFocusedMonth,
    required this.focusedDay,
    required this.datesWithData,
    required this.availabilityData,
    required this.onPreviousMonth,
    required this.onNextMonth,
    required this.onPageChanged,
    required this.onDaySelected,
  });

  // Helper method to check if a day is closed OR fully booked ("Full")
  bool _isDayClosed(DateTime day) {
    return availabilityData.any((entity) {
      final entityDate = DateTime.fromMillisecondsSinceEpoch(
        entity.date,
        isUtc: true,
      );

      final matchesDay = entityDate.year == day.year &&
          entityDate.month == day.month &&
          entityDate.day == day.day;

      // Only returns true if entity.isClosed is explicitly true
      return matchesDay && entity.isClosed;
    });
  }

  Widget _buildDayCell(
    BuildContext context,
    DateTime day, {
    required List<DateTime> datesWithData,
    bool isSelected = false,
    bool isToday = false,
    bool isPast = false,
  }) {
    final bool isClosed = _isDayClosed(day);
    final bool shouldCrossOut = isPast || isClosed;

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
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: shouldCrossOut
              ? Colors.grey
              : isSelected
                  ? Theme.of(context).colorScheme.surface
                  : Theme.of(context).colorScheme.onSurface,
          decoration:
              shouldCrossOut ? TextDecoration.lineThrough : TextDecoration.none,
          decorationColor: Colors.grey,
          decorationThickness: 2.5,
        ),
      ),
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final currentMonth = DateTime(now.year, now.month);
    final displayedMonth = DateTime(
      currentFocusedMonth.year,
      currentFocusedMonth.month,
    );

    final canGoPrevious = displayedMonth.isAfter(currentMonth);

    return Column(
      children: [
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: canGoPrevious ? onPreviousMonth : null,
            ),
            Text(
              DateFormat('MMMM yyyy').format(currentFocusedMonth),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.chevron_right),
              onPressed: onNextMonth,
            ),
          ],
        ),
        Column(
          children: [
            const Row(
              children: [
                Expanded(
                    child: Center(
                        child: Text('M',
                            style: TextStyle(fontWeight: FontWeight.w600)))),
                Expanded(
                    child: Center(
                        child: Text('T',
                            style: TextStyle(fontWeight: FontWeight.w600)))),
                Expanded(
                    child: Center(
                        child: Text('W',
                            style: TextStyle(fontWeight: FontWeight.w600)))),
                Expanded(
                    child: Center(
                        child: Text('T',
                            style: TextStyle(fontWeight: FontWeight.w600)))),
                Expanded(
                    child: Center(
                        child: Text('F',
                            style: TextStyle(fontWeight: FontWeight.w600)))),
                Expanded(
                    child: Center(
                        child: Text('S',
                            style: TextStyle(fontWeight: FontWeight.w600)))),
                Expanded(
                    child: Center(
                        child: Text('S',
                            style: TextStyle(fontWeight: FontWeight.w600)))),
              ],
            ),
            const SizedBox(height: 12),
            TableCalendar(
              rowHeight: 42.0,
              availableGestures: AvailableGestures.none,
              headerVisible: false,
              daysOfWeekVisible: false,
              firstDay: DateTime.utc(2000, 1, 1),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: focusedDay,
              enabledDayPredicate: (day) {
                return !day.isBefore(today) && !_isDayClosed(day);
              },
              onPageChanged: onPageChanged,
              onDaySelected: (selectedDay, focusedDay) {
                if (!selectedDay.isBefore(today) &&
                    !_isDayClosed(selectedDay)) {
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
                    isPast: day.isBefore(today),
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
              selectedDayPredicate: (day) => isSameDay(focusedDay, day),
              availableCalendarFormats: const {
                CalendarFormat.month: 'Month',
              },
            ),
          ],
        )
      ],
    );
  }
}
