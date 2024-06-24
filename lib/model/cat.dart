import 'dart:convert';
import 'package:hive/hive.dart';

part 'cat.g.dart';

@HiveType(typeId: 1)
class cat {
  @HiveField(1)
  final String name;

  @HiveField(2)
  final String breed;

  @HiveField(3)
  final String image;

  const cat({required this.name, required this.breed, required this.image});

  factory cat.fromJson(Map<String, dynamic> json) {
    return cat(name: json['name'], breed: json['breed'], image: json['image']);
  }

  Map<String, dynamic> toJson() =>
      {'name': name, 'breed': breed, 'image': image};
}
