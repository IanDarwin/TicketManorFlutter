import 'package:ticket_manor/model/venue.dart';

import 'event.dart';

enum Sport { baseball, hockey, basketball, soccer, football }

class Game extends Event {
  final Sport sport;
  final String homeTeam;
  final String awayTeam;

  Game({
    required String id,
    required String title,
    required DateTime dateTime,
    required Venue venue,
    required double price,
    String? imageUrl,
    required this.sport,
    required this.homeTeam,
    required this.awayTeam,
  }) : super(
          id: id,
          title: title,
          dateTime: dateTime,
          venue: venue,
          price: price,
          type: EventType.game,
          imageUrl: imageUrl,
        );

  factory Game.fromJson(Map<String, dynamic> json) {
    Sport sport;
    switch (json['sport']) {
      case 'baseball':
        sport = Sport.baseball;
        break;
      case 'hockey':
        sport = Sport.hockey;
        break;
      case 'basketball':
        sport = Sport.basketball;
        break;
      case 'soccer':
        sport = Sport.soccer;
        break;
      case 'football':
        sport = Sport.football;
        break;
      default:
        sport = Sport.baseball; // Default or error
    }
    return Game(
      id: json['id'],
      title: json['title'],
      dateTime: DateTime.parse(json['dateTime']),
      venue: Venue.fromJson(json['venue']),
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'],
      sport: sport,
      homeTeam: json['homeTeam'],
      awayTeam: json['awayTeam'],
    );
  }
}

