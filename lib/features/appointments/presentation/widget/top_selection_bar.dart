import 'package:flutter/material.dart';

import '../../../../core/apptext/app_text.dart';
import '../enums/top_selection_bar_enum.dart';
import 'top_selection_button.dart';

class TopSelectionBar extends StatelessWidget {
  final ActiveAppointmentSelectionBar selectedTab;
  final ValueChanged<ActiveAppointmentSelectionBar> onTabSelected;

  const TopSelectionBar({
    super.key,
    required this.selectedTab,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TopSelectionButton(
          label: AppText.active,
          tabValue: ActiveAppointmentSelectionBar.active,
          selectedTab: selectedTab,
          onTap: onTabSelected,
        ),
        TopSelectionButton(
          label: AppText.past,
          tabValue: ActiveAppointmentSelectionBar.past,
          selectedTab: selectedTab,
          onTap: onTabSelected,
        ),
      ],
    );
  }
}
