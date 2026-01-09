// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'municipality_work.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MunicipalityWorkAdapter extends TypeAdapter<MunicipalityWork> {
  @override
  final int typeId = 9;

  @override
  MunicipalityWork read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MunicipalityWork(
      id: fields[0] as String,
      categoryId: fields[1] as String,
      createdByAdminId: fields[2] as String,
      relatedIssueId: fields[3] as String,
      title: fields[4] as String,
      description: fields[5] as String,
      status: fields[6] as String,
      startDate: fields[7] as DateTime?,
      endDate: fields[8] as DateTime?,
      latitude: fields[9] as double?,
      longitude: fields[10] as double?,
      addressText: fields[11] as String,
      createdAt: fields[12] as DateTime,
      updatedAt: fields[13] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, MunicipalityWork obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.categoryId)
      ..writeByte(2)
      ..write(obj.createdByAdminId)
      ..writeByte(3)
      ..write(obj.relatedIssueId)
      ..writeByte(4)
      ..write(obj.title)
      ..writeByte(5)
      ..write(obj.description)
      ..writeByte(6)
      ..write(obj.status)
      ..writeByte(7)
      ..write(obj.startDate)
      ..writeByte(8)
      ..write(obj.endDate)
      ..writeByte(9)
      ..write(obj.latitude)
      ..writeByte(10)
      ..write(obj.longitude)
      ..writeByte(11)
      ..write(obj.addressText)
      ..writeByte(12)
      ..write(obj.createdAt)
      ..writeByte(13)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MunicipalityWorkAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
