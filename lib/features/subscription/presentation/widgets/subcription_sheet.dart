import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class SubscriptionSheet extends StatelessWidget {
  final List<Package> packages;

  const SubscriptionSheet({super.key, required this.packages});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      shrinkWrap: true,
      children: [
        const Text(
          'Choose a Subscription Plan',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        ...packages.map((package) {
          final product = package.storeProduct;
          return Card(
            child: ListTile(
              title: Text(product.title),
              subtitle: Text(product.description),
              trailing: Text(product.priceString),
              onTap: () async {
                try {
                  final purchaserInfo =
                      await Purchases.purchasePackage(package);

                  final isActive =
                      purchaserInfo.entitlements.all['premium']?.isActive ??
                          false;

                  if (isActive && context.mounted) {
                    Navigator.of(context).pop(); // close the sheet
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Subscription successful!')),
                    );
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Purchase failed: $e')),
                    );
                  }
                }
              },
            ),
          );
        }),
      ],
    );
  }
}
