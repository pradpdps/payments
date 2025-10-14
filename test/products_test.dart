import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:payments/products.dart';

void main() {
  testWidgets('Products widget shows loading indicator initially',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Products(),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Headphones'), findsOneWidget);
  });
}
