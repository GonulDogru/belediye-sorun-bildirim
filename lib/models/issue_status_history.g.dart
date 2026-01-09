// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issue_status_history.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IssueStatusHistoryAdapter extends TypeAdapter<IssueStatusHistory> {
  @override
  final int typeId = 7;

  @override
  IssueStatusHistory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IssueStatusHistory(
      id: fields[0] as String,
      issueId: fields[1] as String,
      changedByUserId: fields[2] as String,
      fromStatus: fields[3] as String,
      toStatus: fields[4] as String,
      note: fields[5] as String,
      changedAt: fields[6] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, IssueStatusHistory obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.issueId)
      ..writeByte(2)
      ..write(obj.changedByUserId)
      ..writeByte(3)
      ..write(obj.fromStatus)
      ..writeByte(4)
      ..write(obj.toStatus)
      ..writeByte(5)
      ..write(obj.note)
      ..writeByte(6)
      ..write(obj.changedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IssueStatusHistoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
