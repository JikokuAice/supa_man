import 'dart:convert';

class cat {
  final String name;
  final String breed;
  final String image;

  const cat({required this.name, required this.breed, required this.image});

  factory cat.fromJson(Map<String, dynamic> json) {
    return cat(name: json['name'], breed: json['breed'], image: json['image']);
  }

  Map<String, dynamic> toJson() =>
      {'name': name, 'breed': breed, 'image': image};
}
