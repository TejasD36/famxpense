// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settlement_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SettlementDtoAdapter extends TypeAdapter<SettlementDto> {
  @override
  final typeId = 5;

  @override
  SettlementDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SettlementDto(
      id: fields[0] as String,
      fromUserId: fields[1] as String,
      toUserId: fields[2] as String,
      amount: (fields[3] as num).toDouble(),
      status: fields[4] as SettlementStatus,
      createdAt: fields[5] as DateTime,
      confirmedAt: fields[6] as DateTime?,
      relatedExpenseIds: (fields[7] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, SettlementDto obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.fromUserId)
      ..writeByte(2)
      ..write(obj.toUserId)
      ..writeByte(3)
      ..write(obj.amount)
      ..writeByte(4)
      ..write(obj.status)
      ..writeByte(5)
      ..write(obj.createdAt)
      ..writeByte(6)
      ..write(obj.confirmedAt)
      ..writeByte(7)
      ..write(obj.relatedExpenseIds);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettlementDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SettlementDto _$SettlementDtoFromJson(Map<String, dynamic> json) =>
    _SettlementDto(
      id: json['id'] as String,
      fromUserId: json['fromUserId'] as String,
      toUserId: json['toUserId'] as String,
      amount: (json['amount'] as num).toDouble(),
      status: $enumDecode(_$SettlementStatusEnumMap, json['status']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      confirmedAt: json['confirmedAt'] == null
          ? null
          : DateTime.parse(json['confirmedAt'] as String),
      relatedExpenseIds: (json['relatedExpenseIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$SettlementDtoToJson(_SettlementDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fromUserId': instance.fromUserId,
      'toUserId': instance.toUserId,
      'amount': instance.amount,
      'status': _$SettlementStatusEnumMap[instance.status]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'confirmedAt': instance.confirmedAt?.toIso8601String(),
      'relatedExpenseIds': instance.relatedExpenseIds,
    };

const _$SettlementStatusEnumMap = {
  SettlementStatus.pending: 'pending',
  SettlementStatus.confirmed: 'confirmed',
  SettlementStatus.rejected: 'rejected',
};
