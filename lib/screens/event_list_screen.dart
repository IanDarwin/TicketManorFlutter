import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart'; // For date and currency formatting

import '../providers/event_provider.dart';
import '../model/event.dart';
import 'event_detail_screen.dart';
import 'cart_screen.dart';

class EventListScreen extends StatelessWidget {
  const EventListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TicketManor Events'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartScreen()),
              );
            },
          ),
        ],
      ),
      body: Consumer<EventProvider>(
        builder: (context, eventProvider, child) {
          if (eventProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (eventProvider.errorMessage != null) {
            return Center(
              child: Text('Error: ${eventProvider.errorMessage}\nPull to refresh.'),
            );
          } else if (eventProvider.events.isEmpty) {
            return const Center(child: Text('No events available.'));
          } else {
            return RefreshIndicator(
              onRefresh: eventProvider.fetchEvents,
              child: ListView.builder(
                itemCount: eventProvider.events.length,
                itemBuilder: (context, index) {
                  final event = eventProvider.events[index];
                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    elevation: 4.0,
                    child: ListTile(
                      leading: event.imageUrl != null && event.imageUrl!.isNotEmpty
                          ? Image.network(
                              event.imageUrl!,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => const Icon(Icons.event),
                            )
                          : const Icon(Icons.event, size: 80),
                      title: Text(event.title),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(event.venue.name),
                          Text(DateFormat('MMM dd, yyyy - hh:mm a').format(event.dateTime)),
                          Text('\$${event.price.toStringAsFixed(2)}'),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EventDetailScreen(event: event),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
