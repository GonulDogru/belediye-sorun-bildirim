// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issue.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IssueAdapter extends TypeAdapter<Issue> {
  @override
  final int typeId = 5;

  @override
  Issue read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Issue(
      id: fields[0] as String,
      userId: fields[1] as String,
      categoryId: fields[2] as String,
      assignedAdminId: fields[3] as String,
      relatedWorkId: fields[4] as String,
      title: fields[5] as String,
      description: fields[6] as String,
      status: fields[7] as String,
      priority: fields[8] as String,
      latitude: fields[9] as double,
      longitude: fields[10] as double,
      addressText: fields[11] as String,
      createdAt: fields[12] as DateTime,
      updatedAt: fields[13] as DateTime,
      closedAt: fields[14] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, Issue obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.categoryId)
      ..writeByte(3)
      ..write(obj.assignedAdminId)
      ..writeByte(4)
      ..write(obj.relatedWorkId)
      ..writeByte(5)
      ..write(obj.title)
      ..writeByte(6)
      ..write(obj.description)
      ..writeByte(7)
      ..write(obj.status)
      ..writeByte(8)
      ..write(obj.priority)
      ..writeByte(9)
      ..write(obj.latitude)
      ..writeByte(10)
      ..write(obj.longitude)
      ..writeByte(11)
      ..write(obj.addressText)
      ..writeByte(12)
      ..write(obj.createdAt)
      ..writeByte(13)
      ..write(obj.updatedAt)
      ..writeByte(14)
      ..write(obj.closedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IssueAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
