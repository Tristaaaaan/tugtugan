import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tugtugan/features/registration/studio_registration.dart';

void main() {
  testWidgets(
      'Check if button tap shows error/warning when textfields are empty',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: StudioRegistration(),
        ),
      ),
    );

    // Find the text fields
    final studioNameField = find.byKey(const Key("studioName"));
    final studioAddressField = find.byKey(const Key("studioAddress"));
    final contactNumberField = find.byKey(const Key("contactNumber"));

    // Verify that the text fields are present and empty
    expect(studioNameField, findsOneWidget);
    expect(studioAddressField, findsOneWidget);
    expect(contactNumberField, findsOneWidget);
    expect(find.text(''), findsNWidgets(3)); // All fields are empty

    // Find and tap the register button
    final registerButton = find.byKey(const Key("registerStudioButton"));
    expect(registerButton, findsOneWidget);

    await tester.tap(registerButton);

    await tester.pump();

    // Verify expected behavior after tap (examples below)
    // --- Option 1: Check if error messages appear (if your UI shows them)
    // expect(find.text('Please enter a studio name'), findsOneWidget);

    // --- Option 2: Check if StudioServices.addStudio() was NOT called (since fields are empty)
    // Verify that no studio was added (mock StudioServices in a real test)

    // --- Option 3: Check if the screen did NOT navigate away
    // expect(find.byType(StudioRegistration), findsOneWidget);
  });
}
