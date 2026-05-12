// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partnership_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PartnershipDtoAdapter extends TypeAdapter<PartnershipDto> {
  @override
  final typeId = 6;

  @override
  PartnershipDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PartnershipDto(
      id: fields[0] as String,
      userA: fields[1] as String,
      userB: fields[2] as String,
      createdAt: fields[3] as DateTime,
      isAccepted: fields[4] == null ? false : fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, PartnershipDto obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userA)
      ..writeByte(2)
      ..write(obj.userB)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.isAccepted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PartnershipDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PartnershipDto _$PartnershipDtoFromJson(Map<String, dynamic> json) =>
    _PartnershipDto(
      id: json['id'] as String,
      userA: json['userA'] as String,
      userB: json['userB'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      isAccepted: json['isAccepted'] as bool? ?? false,
    );

Map<String, dynamic> _$PartnershipDtoToJson(_PartnershipDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userA': instance.userA,
      'userB': instance.userB,
      'createdAt': instance.createdAt.toIso8601String(),
      'isAccepted': instance.isAccepted,
    };
