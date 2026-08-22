import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../studios/presentation/providers/studio_data_providers.dart';
import '../../../studios/presentation/providers/studio_provider.dart';
import '../providers/appointment_providers.dart';
import '../screen/book_appointment.dart';
import '../utils/availability_color.dart';
import '../utils/time_format.dart';

class TimeSlotsContainer extends ConsumerStatefulWidget {
  final String studioId;
  final ScrollController _scrollController;
  const TimeSlotsContainer(
      {super.key,
      required ScrollController scrollController,
      required this.studioId})
      : _scrollController = scrollController;

  @override
  ConsumerState<TimeSlotsContainer> createState() => _TimeSlotsContainerState();
}

class _TimeSlotsContainerState extends ConsumerState<TimeSlotsContainer> {
  @override
  Widget build(BuildContext context) {
    final studioTimeSlot = ref.watch(studioTimeSlotControllerProvider(
      GetStudioTimeSlotParams(
          studioId: widget.studioId,
          selectedDate: ref.read(selectedDayProvider)),
    ));
    return studioTimeSlot.when(
      initial: () => const Center(child: CircularProgressIndicator()),
      loading: () => const Center(child: CircularProgressIndicator()),
      empty: () => const Center(child: Text('No Time Slots')),
      error: (message) => Center(child: Text(message)),
      loaded: (slots) {
        return SizedBox(
          height: 400,
          child: ScrollbarTheme(
            data: ScrollbarThemeData(
              minThumbLength: 50.0,
              thumbColor: WidgetStateProperty.all(
                Theme.of(context).colorScheme.primary,
              ),
              trackColor: WidgetStateProperty.all(
                Theme.of(context).colorScheme.primary.withValues(alpha: 0.15),
              ),
            ),
            child: Scrollbar(
              thumbVisibility: true,
              controller: widget._scrollController,
              child: GridView.builder(
                controller: widget._scrollController,
                padding: const EdgeInsets.only(bottom: 100, right: 10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 2.5,
                ),
                itemCount: slots.appointmentSlots.length,
                itemBuilder: (context, index) {
                  final slot = slots.appointmentSlots[index];
                  final selection = ref.watch(appointmentSelectionProvider);
                  final selectedTimes =
                      ref.watch(appointmentSelectionProvider.notifier);

                  bool isSelected = selection.slots
                      .map((s) => s.startAt)
                      .contains(slot.startAt);

                  return GestureDetector(
                    onTap: () {
                      selectedTimes.toggleSlot(slot);
                    },
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
                                : getAvailabilityColor(Availability.available),
                            width: .3,
                          ),
                          left: BorderSide(
                            color: isSelected
                                ? Theme.of(context).colorScheme.primary
                                : getAvailabilityColor(Availability.available),
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
                            isSelected ? Icons.check_circle : Icons.access_time,
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
                                // Time
                                Text(
                                  TimeFormatUtil.formatTime12Hour(slot.startAt),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: isSelected
                                        ? Theme.of(context).colorScheme.surface
                                        : null,
                                  ),
                                ),
                                // Status
                                Text(
                                  slot.endAt.toString(),
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: isSelected
                                        ? Theme.of(context).colorScheme.surface
                                        : getAvailabilityColor(
                                            Availability.available),
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
        );
      },
    );
  }
}
