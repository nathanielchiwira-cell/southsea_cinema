import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/basket_item.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';
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

const Movie secondTestMovie = Movie(
  id: 'second-movie',
  title: 'Second Movie',
  synopsis: 'Another film for testing.',
  ageRating: '12A',
  screeningTime: 'Saturday 18:00',
  ticketPrice: 6.0,
  imagePath: 'assets/images/second.jpg',
);

void main() {
  final BasketRepository basket = BasketRepository.instance;

  setUp(() {
    basket.clear();
  });

  group('BasketRepository', () {
    test('starts empty with zero totals', () {
      expect(basket.getItems(), isEmpty);
      expect(basket.getTotalTickets(), 0);
      expect(basket.getTotal(), 0.0);
    });

    test('stores movies and quantities and calculates totals', () {
      basket.addItem(const BasketItem(movie: testMovie, quantity: 2));
      basket.addItem(const BasketItem(movie: secondTestMovie, quantity: 1));
      expect(basket.getItems().length, 2);
      expect(basket.getItems().first.movie.id, 'test-movie');
      expect(basket.getItems().first.quantity, 2);
      expect(basket.getItems().first.lineTotal, 20.0);
      expect(basket.getItems().last.movie.id, 'second-movie');
      expect(basket.getTotalTickets(), 3);
      expect(basket.getTotal(), 26.0);
    });

    test('removes the requested line and updates totals', () {
      basket.addItem(const BasketItem(movie: testMovie, quantity: 2));
      basket.addItem(const BasketItem(movie: secondTestMovie, quantity: 1));
      basket.removeItem(0);
      expect(basket.getItems().single.movie.id, 'second-movie');
      expect(basket.getTotalTickets(), 1);
      expect(basket.getTotal(), 6.0);
    });

    test('clear removes every item', () {
      basket.addItem(const BasketItem(movie: testMovie, quantity: 2));
      basket.addItem(const BasketItem(movie: secondTestMovie, quantity: 1));
      basket.clear();
      expect(basket.getItems(), isEmpty);
      expect(basket.getTotalTickets(), 0);
      expect(basket.getTotal(), 0.0);
    });



  });
}
