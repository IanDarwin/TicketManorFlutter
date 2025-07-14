import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/event.dart';
import '../model/concert.dart';
import '../model/play.dart';
import '../model/game.dart';
import '../model/movie.dart';

class ApiService {
  static const String _baseUrl = 'http://ticketmanor.com/rest';
  Future<List<Event>> fetchAllEvents() async {
    final response = await http.get(Uri.parse('$_baseUrl/events'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) {
        // Create the correct event type based on the 'type' field from REST call.
        switch (data['type']) {
          case 'concert':
            return Concert.fromJson(data);
          case 'play':
            return Play.fromJson(data);
          case 'game':
            return Game.fromJson(data);
          case 'movie':
            return Movie.fromJson(data);
          default:
            return Event.fromJson(data); // Fallback or error
        }
      }).toList();
    } else {
      throw Exception('Failed to load events');
    }
  }

  Future<Event> fetchEventDetail(String eventId) async {
    final response = await http.get(Uri.parse('$_baseUrl/events/$eventId'));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      switch (jsonResponse['type']) {
        case 'concert':
          return Concert.fromJson(jsonResponse);
        case 'play':
          return Play.fromJson(jsonResponse);
        case 'game':
          return Game.fromJson(jsonResponse);
        case 'movie':
          return Movie.fromJson(jsonResponse);
        default:
          return Event.fromJson(jsonResponse);
      }
    } else {
      throw Exception('Failed to load event detail');
    }
  }

  // You can add more methods here for filtering, searching, etc.
}
