import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

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
String _formatDateDisplay(String dateString) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = today.subtract(const Duration(days: 1));

  // Parse the stored date (assuming format "month-day-year")
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
    // Return formatted date (e.g., "Jan 5, 2023")
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

Widget _buildDayCell(BuildContext context, DateTime day,
    {bool isSelected = false,
    bool isToday = false,
    required List<DateTime> datesWithData}) {
  Color bgColor;
  Color textColor;
  // Check if the day is in the list of dates with data
  if (datesWithData.contains(DateTime(day.year, day.month, day.day))) {
    // Background color for days with data
    bgColor = Theme.of(context).colorScheme.primary;
    textColor = Theme.of(context).colorScheme.surface;
  } else if (isSelected) {
    bgColor = Theme.of(context).colorScheme.tertiaryContainer;
    textColor = Theme.of(context).colorScheme.surface;
  } else if (isToday) {
    bgColor = Theme.of(context).colorScheme.tertiary;
    textColor = Theme.of(context).colorScheme.inversePrimary;
  } else {
    bgColor = Colors.transparent;
    textColor = Theme.of(context).colorScheme.primaryFixedDim;
  }

  return Container(
    width: double.infinity,
    margin: const EdgeInsets.all(10),
    padding: const EdgeInsets.all(4),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${day.day}',
          style: TextStyle(
            color: textColor,
          ),
        ),
        const SizedBox(height: 4),
      ],
    ),
  );
}

class BookAppointmentScreen extends ConsumerWidget {
  const BookAppointmentScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final focusedDay = ref.watch(focusedDayProvider);
    final currentFocusedMonth = ref.watch(focusedMonthProvider);
    List<DateTime> datesWithData = [];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Data and Preferences"),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left),
                    onPressed: () => _navigateToMonth(ref, -1),
                  ),
                  Text(
                    DateFormat('MMMM yyyy').format(currentFocusedMonth),
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.chevron_right),
                    onPressed: () => _navigateToMonth(ref, 1),
                  ),
                ],
              ),
              TableCalendar(
                availableGestures: AvailableGestures.none,
                headerVisible: false,
                firstDay: DateTime.utc(2000, 1, 1),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: focusedDay,
                onPageChanged: (focusedMonth) {
                  ref.read(focusedMonthProvider.notifier).state = focusedMonth;
                },
                onDaySelected: (selectedDay, focusedDay) {
                  ref.read(focusedDayProvider.notifier).state = selectedDay;
                  developer.log(selectedDay.toString());
                },
                calendarBuilders: CalendarBuilders(
                  defaultBuilder: (context, day, focusedDay) {
                    return _buildDayCell(context, day,
                        datesWithData: datesWithData);
                  },
                  selectedBuilder: (context, day, focusedDay) {
                    return _buildDayCell(context, day,
                        datesWithData: datesWithData, isSelected: true);
                  },
                  todayBuilder: (context, day, focusedDay) {
                    return _buildDayCell(context, day,
                        datesWithData: datesWithData, isToday: true);
                  },
                ),
                selectedDayPredicate: (day) => isSameDay(focusedDay, day),
                availableCalendarFormats: const {CalendarFormat.month: 'Month'},
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
