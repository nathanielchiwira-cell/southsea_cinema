import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/models/basket_item.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';
import 'package:southsea_cinema/widgets/primary_button.dart';

class BasketView extends StatefulWidget {
  const BasketView({super.key});

  @override
  State<BasketView> createState() => _BasketViewState();
}

class _BasketViewState extends State<BasketView> {
  final BasketRepository _basket = BasketRepository.instance;
  String _confirmationMessage = '';

  @override
  Widget build(BuildContext context) {
    final List<BasketItem> items = _basket.getItems();

    return Scaffold(
      appBar: AppBar(title: const Text(appTitle)),
      drawer: const NavDrawer(),
      body: items.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Your basket is empty'),
                  if (_confirmationMessage.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Text(_confirmationMessage),
                  ],
                ],
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Text(
                  'Your basket',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                for (int index = 0; index < items.length; index++)
                  Card(
                    child: ListTile(
                      title: Text(
                        '${items[index].quantity} x ${items[index].movie.title}',
                      ),
                      subtitle: Text(
                        '£${items[index].lineTotal.toStringAsFixed(2)}',
                      ),
                      trailing: IconButton(
                        tooltip: 'Remove item',
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () {
                          setState(() {
                            _basket.removeItem(index);
                          });
                        },
                      ),
                    ),
                  ),
                const SizedBox(height: 16),
                Text('Tickets: ${_basket.getTotalTickets()}'),
                Text('Total: £${_basket.getTotal().toStringAsFixed(2)}'),
                const SizedBox(height: 16),
                PrimaryButton(
                  label: 'Checkout',
                  onPressed: () {
                    setState(() {
                      _basket.clear();
                      _confirmationMessage =
                          'Thanks, your ticket order has been received';
                    });
                  },
                ),
              ],
            ),
    );
  }
}
