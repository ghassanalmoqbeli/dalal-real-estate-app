// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adv_card_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AdvCardEntityAdapter extends TypeAdapter<AdvCardEntity> {
  @override
  final int typeId = 1;

  @override
  AdvCardEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AdvCardEntity(
      isMine: fields[10] as bool,
      isLiked: fields[11] as bool,
      isFaved: fields[12] as bool,
      advStatus: fields[6] as bool?,
      advCardId: fields[1] as String?,
      img: fields[0] as String?,
      date: fields[2] as String?,
      title: fields[3] as String?,
      adress: fields[4] as String?,
      section: fields[5] as String?,
      price: fields[7] as String?,
      likesCount: fields[8] as String?,
      isPremium: fields[9] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, AdvCardEntity obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.img)
      ..writeByte(1)
      ..write(obj.advCardId)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.adress)
      ..writeByte(5)
      ..write(obj.section)
      ..writeByte(6)
      ..write(obj.advStatus)
      ..writeByte(7)
      ..write(obj.price)
      ..writeByte(8)
      ..write(obj.likesCount)
      ..writeByte(9)
      ..write(obj.isPremium)
      ..writeByte(10)
      ..write(obj.isMine)
      ..writeByte(11)
      ..write(obj.isLiked)
      ..writeByte(12)
      ..write(obj.isFaved);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdvCardEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
