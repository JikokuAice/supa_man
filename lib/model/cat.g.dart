// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cat.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CatAdapter extends TypeAdapter<Cat> {
  @override
  final int typeId = 1;

  @override
  Cat read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Cat(
      name: fields[1] as String,
      breed: fields[2] as String,
      id: fields[4] as int,
      image: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Cat obj) {
    writer
      ..writeByte(4)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.breed)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CatAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
