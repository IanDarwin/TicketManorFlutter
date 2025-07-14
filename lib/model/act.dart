class Act {
  final String id;
  final String name;
  final String description;
  final String imageUrl; // Assuming you have image URLs

  Act({required this.id, required this.name, required this.description, required this.imageUrl});

  factory Act.fromJson(Map<String, dynamic> json) {
    return Act(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'] ?? 'https://via.placeholder.com/150', // Default image
    );
  }
}

