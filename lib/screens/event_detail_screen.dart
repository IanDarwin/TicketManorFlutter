import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../model/event.dart';
import '../model/concert.dart';
import '../model/play.dart';
import '../model/game.dart';
import '../model/movie.dart';
import '../providers/cart_provider.dart';

class EventDetailScreen extends StatelessWidget {
  final Event event;

  const EventDetailScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(event.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (event.imageUrl != null && event.imageUrl!.isNotEmpty)
              Center(
                child: Image.network(
                  event.imageUrl!,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 200),
                ),
              ),
            const SizedBox(height: 16.0),
            Text(
              event.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Date & Time: ${DateFormat('MMM dd, yyyy - hh:mm a').format(event.dateTime)}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Venue: ${event.venue.name}, ${event.venue.city}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Price: \$${event.price.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, color: Colors.green, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            _buildEventSpecificDetails(),
            const SizedBox(height: 24.0),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  cartProvider.addItem(event);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${event.title} added to cart!'),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
                icon: const Icon(Icons.add_shopping_cart),
                label: const Text('Add to Cart'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventSpecificDetails() {
    switch (event.type) {
      case EventType.concert:
        final concert = event as Concert;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Artist: ${concert.artist.name}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8.0),
            Text(
              concert.artist.description,
              style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
            ),
          ],
        );
      case EventType.play:
        final play = event as Play;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Director: ${play.director}', style: const TextStyle(fontSize: 16)),
            Text('Cast: ${play.cast.join(', ')}', style: const TextStyle(fontSize: 16)),
          ],
        );
      case EventType.game:
        final game = event as Game;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sport: ${game.sport.name.toUpperCase()}', style: const TextStyle(fontSize: 16)),
            Text('Teams: ${game.homeTeam} vs ${game.awayTeam}', style: const TextStyle(fontSize: 16)),
          ],
        );
      case EventType.movie:
        final movie = event as Movie;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Director: ${movie.director}', style: const TextStyle(fontSize: 16)),
            Text('Main Stars: ${movie.mainStars.join(', ')}', style: const TextStyle(fontSize: 16)),
          ],
        );
      default:
        return const SizedBox.shrink(); // No specific details for generic event
    }
  }
}
