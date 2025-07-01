import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:tugtugan/commons/widgets/buttons/regular_button.dart';

import '../../data/subscription_repo_impl.dart';
import 'subcription_sheet.dart';

class TugtuganStudioProgramScreen extends StatelessWidget {
  const TugtuganStudioProgramScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.blueGrey),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tugtugan Studio Program',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Subscribe to create your own music studio profile, '
                'list your studio, and directly chat with clients looking to book sessions.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: RegularButton(
                  text: "Subscribe",
                  withIcon: false,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  textColor: Theme.of(context).colorScheme.surface,
                  buttonKey: "subscribeButton",
                  width: 150,
                  onTap: () async {
                    try {
                      await initPlatformState();

                      final customerInfo = await Purchases.getCustomerInfo();
                      final entitlement =
                          customerInfo.entitlements.all['Basic'];

                      if (entitlement != null && entitlement.isActive) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('You are already subscribed!')),
                          );
                        }
                        return; // Don't show the paywall
                      }

                      final offerings = await Purchases.getOfferings();
                      final availablePackages =
                          offerings.current?.availablePackages;
                      // final availablePackages =
                      //     await SubscriptionRepoImpl().getAvailablePackages();
                      if (availablePackages != null &&
                          availablePackages.isNotEmpty) {
                        // Show paywall here, or navigate to it
                        if (context.mounted) {
                          showModalBottomSheet(
                            context: context,
                            builder: (_) =>
                                SubscriptionSheet(packages: availablePackages),
                          );
                        }
                      } else {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('No packages available')),
                          );
                        }
                      }
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: $e')),
                        );
                      }
                    }
                    // Handle subscription logic here
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Subscription feature coming soon!')),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
