// import 'package:flutter/material.dart';

// import '../models/payment_models.dart';

// class EwalletPaymentScreen extends StatefulWidget {
//   final double amount;
//   const EwalletPaymentScreen({super.key, required this.amount});

//   @override
//   State<EwalletPaymentScreen> createState() => _EwalletPaymentScreenState();
// }

// class _EwalletPaymentScreenState extends State<EwalletPaymentScreen> {
//   // final bool _processing = false;
//   String? _error;

//   // Future<void> _payWith(EwalletType type) async {
//   //   setState(() {
//   //     _processing = true;
//   //     _error = null;
//   //   });

//   //   try {
//   //     final intent = await PaymentService.instance.createPaymentIntent(
//   //       amount: widget.amount,
//   //       method: type.apiValue,
//   //       description: 'Order payment',
//   //     );

//   //     final user = FirebaseAuth.instance.currentUser;
//   //     final result = await PaymentService.instance.payWithEwallet(
//   //       intent: intent,
//   //       method: type,
//   //       billing: BillingInfo(
//   //         name: user?.displayName ?? 'Customer',
//   //         email: user?.email ?? 'no-email@example.com',
//   //         phone: user?.phoneNumber,
//   //       ),
//   //     );

//   //     if (result.redirectUrl == null) {
//   //       throw Exception('No checkout URL returned - cannot continue.');
//   //     }

//   // final success = await Navigator.of(context).push<bool>(
//   //   MaterialPageRoute(
//   //     builder: (_) => PaymentWebviewScreen(
//   //       checkoutUrl: result.redirectUrl!,
//   //       successUrlPrefix: 'https://example.com/success',
//   //       failedUrlPrefix: 'https://example.com/failed',
//   //     ),
//   //   ),
//   // );

//   //   final status =
//   //       await PaymentService.instance.getStatus(intent.paymentIntentId);
//   //   if (!mounted) return;

//   //   if (success == true && status == 'succeeded') {
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       const SnackBar(content: Text('Payment successful!')),
//   //     );
//   //     Navigator.of(context).pop(true);
//   //   } else {
//   //     setState(() => _error = 'Payment was not completed (status: $status)');
//   //   }
//   // } catch (e) {
//   //   setState(() => _error = e.toString());
//   // } finally {
//   //   if (mounted) setState(() => _processing = false);
//   // }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Pay with e-wallet')),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Text('Total: ₱${widget.amount.toStringAsFixed(2)}',
//                 style: Theme.of(context).textTheme.titleLarge),
//             const SizedBox(height: 24),
//             if (_error != null)
//               Text(_error!, style: const TextStyle(color: Colors.red)),
//             const SizedBox(height: 12),
//             _EwalletButton(
//               label: 'GCash',
//               enabled: !_processing,
//               onTap: () => _payWith(EwalletType.gcash),
//             ),
//             const SizedBox(height: 12),
//             _EwalletButton(
//               label: 'GrabPay',
//               enabled: !_processing,
//               onTap: () => _payWith(EwalletType.grabPay),
//             ),
//             const SizedBox(height: 12),
//             _EwalletButton(
//               label: 'Maya',
//               enabled: !_processing,
//               onTap: () => _payWith(EwalletType.paymaya),
//             ),
//             if (_processing)
//               const Padding(
//                 padding: EdgeInsets.only(top: 24),
//                 child: Center(child: CircularProgressIndicator()),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _EwalletButton extends StatelessWidget {
//   final String label;
//   final bool enabled;
//   final VoidCallback onTap;

//   const _EwalletButton(
//       {required this.label, required this.enabled, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return OutlinedButton(
//       onPressed: enabled ? onTap : null,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 14),
//         child: Text(label),
//       ),
//     );
//   }
// }
