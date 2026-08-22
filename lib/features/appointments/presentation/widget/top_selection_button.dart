import 'package:flutter/material.dart';
import 'package:tugtugan/features/appointments/presentation/enums/top_selection_bar_enum.dart';

class TopSelectionButton extends StatelessWidget {
  final String label;
  final ActiveAppointmentSelectionBar tabValue;
  final ActiveAppointmentSelectionBar selectedTab;
  final ValueChanged<ActiveAppointmentSelectionBar> onTap;

  const TopSelectionButton({
    super.key,
    required this.label,
    required this.tabValue,
    required this.selectedTab,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedTab == tabValue;

    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(tabValue),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(
                        context,
                      ).colorScheme.primary.withValues(alpha: 0.2),
                width: isSelected ? 2 : 1,
              ),
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.primaryFixedDim,
            ),
          ),
        ),
      ),
    );
  }
}
