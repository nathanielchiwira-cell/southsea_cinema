import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/main.dart';
import 'package:southsea_cinema/widgets/movie_card.dart';

void main() {
  setUp(() {
    rootBundle.clear();
  });

  testWidgets('home page displays title, movie cards and booking buttons',
      (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(1000, 1600));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const SouthseaCinemaApp());
    await tester.pumpAndSettle();

    expect(
      find.text('Southsea Cinema & Arts Centre'),
      findsOneWidget,
    );

    expect(find.byType(MovieCard), findsWidgets);

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
      findsWidgets,
    );
  });
}
