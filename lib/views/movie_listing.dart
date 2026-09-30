import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';

class MovieListing extends StatefulWidget {
  const MovieListing({super.key});

  @override
  State<MovieListing> createState() => _MovieListingState();
}

class _MovieListingState extends State<MovieListing> {
  int _selectedTickets = 0;   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appTitle, style: cinemaHeaderStyle),
        backgroundColor: cinemaSurface,
        iconTheme: const IconThemeData(color: cinemaBrand),
        elevation: 0,
      ),
      drawer: const NavDrawer(),
      body: _buildBody(),
    );
  }

Widget _buildBody() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 16.0),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Spider-Man: No Way Home (2021) (PG-13)",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), 
              ),
              SizedBox(height: 8),
              Text(
                "Science Fiction, Action, Adventure at Cinema Room.\n"
                "Friday 17 Aug 2024 19:30 - 22:00.",
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Age rating and duration
        const Text("Age Rating: PG-13"),
        const Text("Duration: 2h 28m"),

        const SizedBox(height: 24),

        // Ticket quantity selection
        const Text("Select Ticket Quantity (up to 5 in total)"),
        const SizedBox(height: 8),

        //Dropdown for ticket quantity selection  
        DropdownMenu<int>(
          initialSelection: _selectedTickets,
          onSelected: (int? value) {
            if (value != null) {
              setState(() {
                _selectedTickets = value;
              });
            }
          },
          dropdownMenuEntries: const [
            DropdownMenuEntry(value: 0, label: "0 Adult (£7.50)"),
            DropdownMenuEntry(value: 1, label: "1 Adult (£7.50)"),
            DropdownMenuEntry(value: 2, label: "2 Adults (£15.00)"),
            DropdownMenuEntry(value: 3, label: "3 Adults (£22.50)"),
            DropdownMenuEntry(value: 4, label: "4 Adults (£30.00)"),
            DropdownMenuEntry(value: 5, label: "5 Adults (£37.50)"),
          ],
        ),

        const SizedBox(height: 24),

        // Booking button
        Center(
          child: ElevatedButton(
            onPressed: () {
              // demo 1
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Added $_selectedTickets ticket(s) to your booking.",
                  ),
                ),
              );
            },
            child: const Text("Add to Booking"),
          ),
        ),
      ],
    ),
  );
}
}
