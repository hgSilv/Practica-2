// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_reminder.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReminderAdapter extends TypeAdapter<TodoRemainder> {
  @override
  final int typeId = 1;

  @override
  TodoRemainder read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TodoRemainder(
      todoDescription: fields[0] as String,
      hour: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TodoRemainder obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.todoDescription)
      ..writeByte(1)
      ..write(obj.hour);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReminderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
