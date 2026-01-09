// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcement.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AnnouncementAdapter extends TypeAdapter<Announcement> {
  @override
  final int typeId = 10;

  @override
  Announcement read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Announcement(
      id: fields[0] as String,
      createdByAdminId: fields[1] as String,
      categoryId: fields[2] as String,
      title: fields[3] as String,
      content: fields[4] as String,
      isPublished: fields[5] as bool,
      publishAt: fields[6] as DateTime?,
      createdAt: fields[7] as DateTime,
      updatedAt: fields[8] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Announcement obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createdByAdminId)
      ..writeByte(2)
      ..write(obj.categoryId)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.content)
      ..writeByte(5)
      ..write(obj.isPublished)
      ..writeByte(6)
      ..write(obj.publishAt)
      ..writeByte(7)
      ..write(obj.createdAt)
      ..writeByte(8)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnnouncementAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
