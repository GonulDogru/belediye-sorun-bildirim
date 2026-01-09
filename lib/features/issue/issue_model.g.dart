// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issue_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IssueModelAdapter extends TypeAdapter<IssueModel> {
  @override
  final int typeId = 0;

  @override
  IssueModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IssueModel(
      id: fields[0] as String,
      description: fields[1] as String,
      imagePath: fields[2] as String,
      latitude: fields[3] as double,
      longitude: fields[4] as double,
      address: fields[5] as String,
      createdAt: fields[6] as DateTime,
      status: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, IssueModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.imagePath)
      ..writeByte(3)
      ..write(obj.latitude)
      ..writeByte(4)
      ..write(obj.longitude)
      ..writeByte(5)
      ..write(obj.address)
      ..writeByte(6)
      ..write(obj.createdAt)
      ..writeByte(7)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IssueModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
