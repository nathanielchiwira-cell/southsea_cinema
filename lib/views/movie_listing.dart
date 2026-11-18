import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/models/basket_item.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';
import 'package:southsea_cinema/widgets/primary_button.dart';

class MovieListing extends StatefulWidget {
  final Movie movie;

  const MovieListing({
    super.key,
    required this.movie,
  });

  @override
  State<MovieListing> createState() => _MovieListingState();
}

class _MovieListingState extends State<MovieListing> {
  int _selectedTickets = 0;
  String _confirmationMessage = '';

  void _addToBasket() {
    if (_selectedTickets > 0) {
      final BasketItem item = BasketItem(
        movie: widget.movie,
        quantity: _selectedTickets,
      );

      BasketRepository.instance.addItem(item);

      setState(() {
        _confirmationMessage =
            'Added $_selectedTickets ticket(s) for '
            '${widget.movie.title} to basket';
      });
    } else {
      setState(() {
        _confirmationMessage = 'Please select at least 1 ticket';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appTitle),
      ),
      drawer: const NavDrawer(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.movie.title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(widget.movie.synopsis),
          const SizedBox(height: 8),
          Text('Age Rating: ${widget.movie.ageRating}'),
          Text('Showing at: ${widget.movie.screeningTime}'),
          Text('Ticket price: ${widget.movie.formattedPrice}'),
          const SizedBox(height: 24),

          const Text('Select Ticket Quantity (up to 5 in total)'),
          const SizedBox(height: 8),

          DropdownMenu<int>(
            initialSelection: _selectedTickets,
            enableFilter: false,
            enableSearch: false,
            onSelected: (int? value) {
              if (value != null) {
                setState(() {
                  _selectedTickets = value;
                });
              }
            },
            dropdownMenuEntries: List.generate(6, (int quantity) {
              return DropdownMenuEntry<int>(
                value: quantity,
                label: '$quantity ticket(s)',
              );
            }),
          ),
          const SizedBox(height: 24),

          PrimaryButton(
            label: 'Add to Basket',
            onPressed: _addToBasket,
          ),
          const SizedBox(height: 12),

          Text(_confirmationMessage),
        ],
      ),
    );
  }
}