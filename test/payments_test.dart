import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:payments/ui/payments.dart';

void main() {
  testWidgets('Payments screen displays correct info',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(home: Payments(123.45)),
    );
    expect(find.text('Select Payment Method'), findsOneWidget);
    expect(find.text('Paying to: Online Store Inc.'), findsOneWidget);
    expect(find.text('\$123.45'), findsOneWidget);
    expect(find.text('Visa **** 134'), findsOneWidget);
    expect(find.text('Apple Pay'), findsOneWidget);
    expect(find.text('Bank Transfer'), findsOneWidget);
    expect(find.text('Add New Bank Account'), findsOneWidget);
    expect(find.text('Pay Now'), findsOneWidget);
  });

  testWidgets('Selecting payment methods updates selection',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(home: Payments(50.0)),
    );
    // Visa is selected by default
    expect(
      tester
          .widget<Icon>(find
              .descendant(
                of: find.widgetWithText(ListTile, 'Visa **** 134'),
                matching: find.byType(Icon),
              )
              .last)
          .icon,
      Icons.radio_button_checked,
    );

    // Tap Apple Pay
    await tester.tap(find.text('Apple Pay'));
    await tester.pump();
    expect(
      tester
          .widget<Icon>(find
              .descendant(
                of: find.widgetWithText(ListTile, 'Apple Pay'),
                matching: find.byType(Icon),
              )
              .last)
          .icon,
      Icons.radio_button_checked,
    );

    // Tap Bank Transfer
    await tester.tap(find.text('Bank Transfer'));
    await tester.pump();
    expect(
      tester
          .widget<Icon>(find
              .descendant(
                of: find.widgetWithText(ListTile, 'Bank Transfer'),
                matching: find.byType(Icon),
              )
              .last)
          .icon,
      Icons.radio_button_checked,
    );
  });

  testWidgets('Tapping Add New Bank Account does nothing',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(home: Payments(10.0)),
    );
    await tester.tap(find.text('Add New Bank Account'));
    await tester.pumpAndSettle();
    // No dialog or error should occur
    expect(find.text('Add New Bank Account'), findsOneWidget);
  });
}
