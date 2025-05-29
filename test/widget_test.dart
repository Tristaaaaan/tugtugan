import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tugtugan/features/registration/studio_registration.dart';

void main() {
  testWidgets('Check if any of the three textfields is empty',
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

    // Verify that the text fields are present
    expect(studioNameField, findsOneWidget);
    expect(studioAddressField, findsOneWidget);
    expect(contactNumberField, findsOneWidget);

    // Enter empty text into the text fields
    await tester.enterText(studioNameField, '');
    await tester.enterText(studioAddressField, '');
    await tester.enterText(contactNumberField, '');

    // Verify that the fields are still empty
    expect(find.text(''), findsNWidgets(3));
  });
}
