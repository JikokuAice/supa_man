import 'dart:convert';

class cat {
  final String name;
  final String Breed;
  final String image;

  const cat({required this.name, required this.Breed, required this.image});

  factory cat.fromJson(Map<String, dynamic> json) {
    return cat(name: json['name'], Breed: json['Breed'], image: json['image']);
  }

  Map<String, dynamic> toJson() =>
      {'name': name, 'Breed': Breed, 'image': image};
}
