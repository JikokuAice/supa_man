// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Users.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Users _$UsersFromJson(Map<String, dynamic> json) => Users(
      id: (json['id'] as num?)?.toInt() ?? 1,
      name: json['name'] as String,
      email: json['email'] as String,
      Password: json['Password'] as String,
      confirm: json['confirm'] as String,
      desc: json['desc'] as String? ?? "a hoomen",
      image: json['image'] as String? ??
          "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
    );

Map<String, dynamic> _$UsersToJson(Users instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'Password': instance.Password,
      'confirm': instance.confirm,
      'image': instance.image,
      'desc': instance.desc,
    };
