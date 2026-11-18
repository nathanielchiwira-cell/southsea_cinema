import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/basket_item.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';
import 'package:southsea_cinema/views/basket_view.dart';
import 'package:southsea_cinema/models/movie.dart';

const Movie testMovie = Movie(
  id: 'test-movie',
  title: 'Test Movie',
  synopsis: 'A film for testing.',
  ageRating: 'PG',
  screeningTime: 'Friday 19:30',
  ticketPrice: 10.0,
  imagePath: 'assets/images/test.jpg',
);


void main() {
  final basket = BasketRepository.instance;
  setUp(() => basket.clear());

  testWidgets('shows empty state without clear button', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: BasketView()));
    expect(find.text('Your basket is empty'), findsOneWidget);
    expect(find.text('Checkout'), findsNothing);
  });

  testWidgets('shows tickets and total then removes a line', (tester) async {
    basket.addItem(const BasketItem(movie: testMovie, quantity: 2));
    await tester.pumpWidget(const MaterialApp(home: BasketView()));
    expect(find.text('2 x Test Movie'), findsOneWidget);
    expect(find.text('£20.00'), findsOneWidget);
    expect(find.text('Tickets: 2'), findsOneWidget);
    expect(find.text('Total: £20.00'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.delete_outline));
    await tester.pump();
    expect(find.text('Your basket is empty'), findsOneWidget);
    expect(basket.getItems(), isEmpty);
  });

  testWidgets('Checkout clears tickets and keeps confirmation visible', (tester) async {
    basket.addItem(const BasketItem(movie: testMovie, quantity: 2));
    await tester.pumpWidget(const MaterialApp(home: BasketView()));
    expect(find.text('Checkout'), findsOneWidget);
    await tester.ensureVisible(find.text('Checkout'));
    await tester.tap(find.text('Checkout'));
    await tester.pump();
    expect(basket.getItems(), isEmpty);
    expect(basket.getTotalTickets(), 0);
    expect(basket.getTotal(), 0.0);
    expect(find.text('Your basket is empty'), findsOneWidget);
    expect(
      find.text('Thanks, your ticket order has been received'),
      findsOneWidget,
    );
    expect(find.text('Checkout'), findsNothing);
  });

}
