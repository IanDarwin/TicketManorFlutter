import 'package:ticket_manor/model/venue.dart';

import 'event.dart';

class Play extends Event {
  final String director;
  final List<String> cast;

  Play({
    required String id,
    required String title,
    required DateTime dateTime,
    required Venue venue,
    required double price,
    String? imageUrl,
    required this.director,
    required this.cast,
  }) : super(
          id: id,
          title: title,
          dateTime: dateTime,
          venue: venue,
          price: price,
          type: EventType.play,
          imageUrl: imageUrl,
        );

  factory Play.fromJson(Map<String, dynamic> json) {
    return Play(
      id: json['id'],
      title: json['title'],
      dateTime: DateTime.parse(json['dateTime']),
      venue: Venue.fromJson(json['venue']),
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'],
      director: json['director'],
      cast: List<String>.from(json['cast']),
    );
  }
}

