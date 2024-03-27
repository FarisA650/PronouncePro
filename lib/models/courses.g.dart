// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'courses.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CoursesAdapter extends TypeAdapter<Courses> {
  @override
  final int typeId = 1;

  @override
  Courses read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Courses(
      title: fields[0] as String,
      courseDescription: fields[1] as String,
      beginnerLessons: (fields[2] as List?)?.cast<dynamic>(),
      intermediateLessons: (fields[3] as List?)?.cast<dynamic>(),
      advancedLessons: (fields[4] as List?)?.cast<dynamic>(),
      isSelected: fields[5] as bool?,
      isWishListed: fields[6] as bool?,
      lessonProgress: fields[7] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Courses obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.courseDescription)
      ..writeByte(2)
      ..write(obj.beginnerLessons)
      ..writeByte(3)
      ..write(obj.intermediateLessons)
      ..writeByte(4)
      ..write(obj.advancedLessons)
      ..writeByte(5)
      ..write(obj.isSelected)
      ..writeByte(6)
      ..write(obj.isWishListed)
      ..writeByte(7)
      ..write(obj.lessonProgress);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CoursesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
