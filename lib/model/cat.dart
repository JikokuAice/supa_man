import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'cat.g.dart';

@HiveType(typeId: 1)
class Cat extends Equatable {
  @HiveField(1)
  final String name;

  @HiveField(2)
  final String breed;

  @HiveField(3)
  final String image;

  @HiveField(4)
  final int id;

  const Cat(
      {required this.name,
      required this.breed,
      this.id = 0,
      this.image =
          "https://static.vecteezy.com/system/resources/thumbnails/005/544/718/small_2x/profile-icon-design-free-vector.jpg"});

  factory Cat.fromJson(Map<String, dynamic> json) {
    return Cat(
      name: json['name'],
      breed: json['breed'],
      image: json['image'],
      id: json['id'],
    );
  }
  Map<String, dynamic> toJson() =>
      {'name': name, 'breed': breed, 'image': image};

  toList() {}

  @override
  List<Object?> get props => [id, name, breed, image];
}
