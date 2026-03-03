// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loggedin_user_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LoggedinUserEntityAdapter extends TypeAdapter<LoggedinUserEntity> {
  @override
  final int typeId = 0;

  @override
  LoggedinUserEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LoggedinUserEntity(
      uToken: fields[0] as String?,
      uId: fields[1] as String?,
      uName: fields[2] as String?,
      uPhone: fields[3] as String?,
      uWhatsapp: fields[4] as String?,
      uProfileImage: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, LoggedinUserEntity obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.uToken)
      ..writeByte(1)
      ..write(obj.uId)
      ..writeByte(2)
      ..write(obj.uName)
      ..writeByte(3)
      ..write(obj.uPhone)
      ..writeByte(4)
      ..write(obj.uWhatsapp)
      ..writeByte(5)
      ..write(obj.uProfileImage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoggedinUserEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
