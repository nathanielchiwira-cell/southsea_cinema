import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/main.dart';
import 'package:southsea_cinema/widgets/movie_card.dart';

void main() {
  testWidgets('home page displays title, movie cards and booking buttons',
      (WidgetTester tester) async {
    // Give both movie cards enough room to appear.
    await tester.binding.setSurfaceSize(const Size(1000, 1600));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    // Start the app and wait for it to finish rendering.
    await tester.pumpWidget(const SouthseaCinemaApp());
    await tester.pumpAndSettle();

    expect(
      find.text('Southsea Cinema & Arts Centre'),
      findsOneWidget,
    );

    expect(find.byType(MovieCard), findsNWidgets(2));

    expect(
      find.text("Marvels's Spider-Man: No Way Home (2021)"),
      findsOneWidget,
    );

    expect(
      find.text('Black Panther (2018)'),
      findsOneWidget,
    );

    expect(
      find.widgetWithText(ElevatedButton, 'Book Tickets'),
      findsNWidgets(2),
    );
  });
}
