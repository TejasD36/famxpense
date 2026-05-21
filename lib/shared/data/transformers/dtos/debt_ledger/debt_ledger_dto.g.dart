// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debt_ledger_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DebtLedgerDtoAdapter extends TypeAdapter<DebtLedgerDto> {
  @override
  final typeId = 7;

  @override
  DebtLedgerDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DebtLedgerDto(
      id: fields[0] as String,
      userA: fields[1] as String,
      userB: fields[2] as String,
      netBalance: (fields[3] as num).toDouble(),
      updatedAt: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, DebtLedgerDto obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userA)
      ..writeByte(2)
      ..write(obj.userB)
      ..writeByte(3)
      ..write(obj.netBalance)
      ..writeByte(4)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DebtLedgerDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DebtLedgerDto _$DebtLedgerDtoFromJson(Map<String, dynamic> json) =>
    _DebtLedgerDto(
      id: json['id'] as String,
      userA: json['userA'] as String,
      userB: json['userB'] as String,
      netBalance: (json['netBalance'] as num).toDouble(),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$DebtLedgerDtoToJson(_DebtLedgerDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userA': instance.userA,
      'userB': instance.userB,
      'netBalance': instance.netBalance,
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
