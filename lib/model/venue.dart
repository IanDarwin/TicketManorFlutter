class Venue {
  final String id;
  final String name;
  final String address;
  final String city;
  final String state;
  final String zip;

  Venue({required this.id, required this.name, required this.address, required this.city, required this.state, required this.zip});

  factory Venue.fromJson(Map<String, dynamic> json) {
    return Venue(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      city: json['city'],
      state: json['state'],
      zip: json['zip'],
    );
  }
}

