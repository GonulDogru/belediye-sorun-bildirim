// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issue_comment.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IssueCommentAdapter extends TypeAdapter<IssueComment> {
  @override
  final int typeId = 8;

  @override
  IssueComment read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IssueComment(
      id: fields[0] as String,
      issueId: fields[1] as String,
      userId: fields[2] as String,
      message: fields[3] as String,
      isInternal: fields[4] as bool,
      createdAt: fields[5] as DateTime,
      updatedAt: fields[6] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, IssueComment obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.issueId)
      ..writeByte(2)
      ..write(obj.userId)
      ..writeByte(3)
      ..write(obj.message)
      ..writeByte(4)
      ..write(obj.isInternal)
      ..writeByte(5)
      ..write(obj.createdAt)
      ..writeByte(6)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IssueCommentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
