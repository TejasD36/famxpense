// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manual_deposit_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ManualDepositDtoAdapter extends TypeAdapter<ManualDepositDto> {
  @override
  final typeId = 17;

  @override
  ManualDepositDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ManualDepositDto(
      id: fields[0] as String,
      accountId: fields[1] as String,
      amount: (fields[2] as num).toDouble(),
      description: fields[3] as String,
      createdAt: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ManualDepositDto obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.accountId)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ManualDepositDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ManualDepositDto _$ManualDepositDtoFromJson(Map<String, dynamic> json) =>
    _ManualDepositDto(
      id: json['id'] as String,
      accountId: json['accountId'] as String,
      amount: (json['amount'] as num).toDouble(),
      description: json['description'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$ManualDepositDtoToJson(_ManualDepositDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'accountId': instance.accountId,
      'amount': instance.amount,
      'description': instance.description,
      'createdAt': instance.createdAt.toIso8601String(),
    };
