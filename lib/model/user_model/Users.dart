import 'package:json_annotation/json_annotation.dart';

part 'Users.g.dart';

@JsonSerializable()
class Users {
  Users(
      {this.id = 1,
      required this.name,
      required this.email,
      required this.Password,
      required this.confirm,
      this.desc = "a hoomen",
      this.image =
          "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png"});
  final int id;
  final String name;
  final String email;
  final String Password;
  final String confirm;
  final String? image;
  final String? desc;

  factory Users.fromJson(Map<String, dynamic> json) => _$UsersFromJson(json);

  Map<String, dynamic> toJson() => _$UsersToJson(this);
}
