import 'package:ticket_manor/model/venue.dart';

enum EventType { concert, play, game, movie }

// Base class for Concert, Play, Game, etc
class Event {
  final String id;
  final String title;
  final DateTime dateTime;
  final Venue venue;
  final double price;
  final EventType type;
  final String? imageUrl; // Optional image URL for the event itself

  Event({
    required this.id,
    required this.title,
    required this.dateTime,
    required this.venue,
    required this.price,
    required this.type,
    this.imageUrl,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    EventType type;
    switch (json['type']) {
      case 'concert':
        type = EventType.concert;
        break;
      case 'play':
        type = EventType.play;
        break;
      case 'game':
        type = EventType.game;
        break;
      case 'movie':
        type = EventType.movie;
        break;
      default:
        type = EventType.concert; // Default or throw error
    }

    return Event(
      id: json['id'],
      title: json['title'],
      dateTime: DateTime.parse(json['dateTime']),
      venue: Venue.fromJson(json['venue']),
      price: (json['price'] as num).toDouble(),
      type: type,
      imageUrl: json['imageUrl'],
    );
  }
}

