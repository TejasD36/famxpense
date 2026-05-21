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
      senderId: fields[1] as String,
      senderEmail: fields[2] as String,
      senderNickname: fields[3] as String,
      receiverId: fields[4] as String,
      receiverEmail: fields[5] as String,
      receiverNickname: fields[6] as String,
      status: fields[7] as PartnershipStatus,
      createdAt: fields[8] as DateTime,
      updatedAt: fields[9] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, PartnershipDto obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.senderId)
      ..writeByte(2)
      ..write(obj.senderEmail)
      ..writeByte(3)
      ..write(obj.senderNickname)
      ..writeByte(4)
      ..write(obj.receiverId)
      ..writeByte(5)
      ..write(obj.receiverEmail)
      ..writeByte(6)
      ..write(obj.receiverNickname)
      ..writeByte(7)
      ..write(obj.status)
      ..writeByte(8)
      ..write(obj.createdAt)
      ..writeByte(9)
      ..write(obj.updatedAt);
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
      senderId: json['senderId'] as String,
      senderEmail: json['senderEmail'] as String,
      senderNickname: json['senderNickname'] as String,
      receiverId: json['receiverId'] as String,
      receiverEmail: json['receiverEmail'] as String,
      receiverNickname: json['receiverNickname'] as String,
      status: $enumDecode(_$PartnershipStatusEnumMap, json['status']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$PartnershipDtoToJson(_PartnershipDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'senderId': instance.senderId,
      'senderEmail': instance.senderEmail,
      'senderNickname': instance.senderNickname,
      'receiverId': instance.receiverId,
      'receiverEmail': instance.receiverEmail,
      'receiverNickname': instance.receiverNickname,
      'status': _$PartnershipStatusEnumMap[instance.status]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$PartnershipStatusEnumMap = {
  PartnershipStatus.pending: 'pending',
  PartnershipStatus.accepted: 'accepted',
  PartnershipStatus.rejected: 'rejected',
};
