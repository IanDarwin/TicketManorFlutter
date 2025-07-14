import 'package:ticket_manor/model/venue.dart';

import 'event.dart';

class Movie extends Event {
  final String director;
  final List<String> mainStars;

  Movie({
    required String id,
    required String title,
    required DateTime dateTime,
    required Venue venue,
    required double price,
    String? imageUrl,
    required this.director,
    required this.mainStars,
  }) : super(
          id: id,
          title: title,
          dateTime: dateTime,
          venue: venue,
          price: price,
          type: EventType.movie,
          imageUrl: imageUrl,
        );

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      dateTime: DateTime.parse(json['dateTime']),
      venue: Venue.fromJson(json['venue']),
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'],
      director: json['director'],
      mainStars: List<String>.from(json['mainStars']),
    );
  }
}

