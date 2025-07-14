class Concert extends Event {
  final Act artist; // Assuming a concert has an artist (Act)

  Concert({
    required String id,
    required String title,
    required DateTime dateTime,
    required Venue venue,
    required double price,
    String? imageUrl,
    required this.artist,
  }) : super(
          id: id,
          title: title,
          dateTime: dateTime,
          venue: venue,
          price: price,
          type: EventType.concert,
          imageUrl: imageUrl,
        );

  factory Concert.fromJson(Map<String, dynamic> json) {
    return Concert(
      id: json['id'],
      title: json['title'],
      dateTime: DateTime.parse(json['dateTime']),
      venue: Venue.fromJson(json['venue']),
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'],
      artist: Act.fromJson(json['artist']),
    );
  }
}

