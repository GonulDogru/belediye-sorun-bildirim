// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issue_photo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IssuePhotoAdapter extends TypeAdapter<IssuePhoto> {
  @override
  final int typeId = 6;

  @override
  IssuePhoto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IssuePhoto(
      id: fields[0] as String,
      issueId: fields[1] as String,
      localPath: fields[2] as String,
      caption: fields[3] as String,
      takenAt: fields[4] as DateTime?,
      createdAt: fields[5] as DateTime,
      lat: fields[6] as double?,
      lng: fields[7] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, IssuePhoto obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.issueId)
      ..writeByte(2)
      ..write(obj.localPath)
      ..writeByte(3)
      ..write(obj.caption)
      ..writeByte(4)
      ..write(obj.takenAt)
      ..writeByte(5)
      ..write(obj.createdAt)
      ..writeByte(6)
      ..write(obj.lat)
      ..writeByte(7)
      ..write(obj.lng);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IssuePhotoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
