import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';
import 'package:southsea_cinema/views/movie_listing.dart';
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
  setUp(() => BasketRepository.instance.clear());

  testWidgets('shows selected film, price and booking controls', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: MovieListing(movie: testMovie)),
    );
    expect(find.text('Test Movie'), findsOneWidget);
    expect(find.text('Ticket price: £10.00'), findsOneWidget);
    expect(find.byType(DropdownMenu<int>), findsOneWidget);
    expect(find.text('Add to Basket'), findsOneWidget);
  });

  testWidgets('zero tickets shows a warning and does not add a line', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: MovieListing(movie: testMovie)),
    );
    await tester.tap(find.text('Add to Basket'));
    await tester.pump();
    expect(find.text('Please select at least 1 ticket'), findsOneWidget);
    expect(BasketRepository.instance.getItems(), isEmpty);
  });

  testWidgets('selecting two tickets stores the selected film and total', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: MovieListing(movie: testMovie)),
    );
    await tester.tap(find.byType(DropdownMenu<int>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('2 ticket(s)').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Add to Basket'));
    await tester.pump();

    final items = BasketRepository.instance.getItems();
    expect(items.length, 1);
    expect(items.single.movie.id, 'test-movie');
    expect(items.single.quantity, 2);
    expect(BasketRepository.instance.getTotal(), 20.0);
    expect(
      find.text('Added 2 ticket(s) for Test Movie to basket'),
      findsOneWidget,
    );
  });
}
