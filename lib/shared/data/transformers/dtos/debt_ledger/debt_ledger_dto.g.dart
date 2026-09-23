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
      pendingMutations: fields[5] == null
          ? {}
          : (fields[5] as Map).cast<String, double>(),
      appliedMutationIds: fields[6] == null
          ? []
          : (fields[6] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, DebtLedgerDto obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userA)
      ..writeByte(2)
      ..write(obj.userB)
      ..writeByte(3)
      ..write(obj.netBalance)
      ..writeByte(4)
      ..write(obj.updatedAt)
      ..writeByte(5)
      ..write(obj.pendingMutations)
      ..writeByte(6)
      ..write(obj.appliedMutationIds);
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
      pendingMutations:
          (json['pendingMutations'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toDouble()),
          ) ??
          const {},
      appliedMutationIds:
          (json['appliedMutationIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$DebtLedgerDtoToJson(_DebtLedgerDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userA': instance.userA,
      'userB': instance.userB,
      'netBalance': instance.netBalance,
      'updatedAt': instance.updatedAt.toIso8601String(),
      'pendingMutations': instance.pendingMutations,
      'appliedMutationIds': instance.appliedMutationIds,
    };
