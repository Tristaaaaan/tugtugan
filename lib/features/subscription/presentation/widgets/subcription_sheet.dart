import 'package:flutter/material.dart';
import '../../domain/model/package_model.dart';

class SubscriptionSheet extends StatelessWidget {
  final List<MockPackage> packages;

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
          final product = package.product;
          return Card(
            child: ListTile(
              title: Text(product.title),
              subtitle: Text(product.description),
              trailing: Text(product.priceString),
              onTap: () async {
                // try {
                // final purchaserInfo =
                //     await Purchases.purchasePackage(package);

                // final isActive =
                //     purchaserInfo.entitlements.all['premium']?.isActive ??
                //         false;

                // if (isActive && context.mounted) {
                Navigator.of(context).pop(); // close the sheet
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Subscription successful!')),
                );
                //   }
                // } catch (e) {
                //   if (context.mounted) {
                //     ScaffoldMessenger.of(context).showSnackBar(
                //       SnackBar(content: Text('Purchase failed: $e')),
                //     );
                //   }
                // }
              },
            ),
          );
        }),
      ],
    );
  }
}
