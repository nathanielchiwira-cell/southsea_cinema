import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/widgets/primary_button.dart';

void main() {
  group('PrimaryButton', () {
    testWidgets('displays its label', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimaryButton(
              label: 'Book Tickets',
              onPressed: () {},
            ),
          ),
        ),
      );
      expect(find.text('Book Tickets'), findsOneWidget);
    });

    testWidgets('runs callback when tapped', (WidgetTester tester) async {
      bool wasPressed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimaryButton(
              label: 'Book Tickets',
              onPressed: () {
                wasPressed = true;
              },
            ),
          ),
        ),
      );
      await tester.tap(find.text('Book Tickets'));
      await tester.pump();
      expect(wasPressed, isTrue);
    });
  });
}
