// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'income_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IncomeDtoAdapter extends TypeAdapter<IncomeDto> {
  @override
  final typeId = 20;

  @override
  IncomeDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IncomeDto(
      id: fields[0] as String,
      userId: fields[1] as String,
      accountId: fields[2] as String,
      amount: (fields[3] as num).toDouble(),
      source: fields[4] as IncomeSource,
      description: fields[5] as String,
      createdAt: fields[6] as DateTime,
      updatedAt: fields[7] as DateTime,
      syncStatus: fields[8] == null
          ? SyncStatus.pending
          : fields[8] as SyncStatus,
    );
  }

  @override
  void write(BinaryWriter writer, IncomeDto obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.accountId)
      ..writeByte(3)
      ..write(obj.amount)
      ..writeByte(4)
      ..write(obj.source)
      ..writeByte(5)
      ..write(obj.description)
      ..writeByte(6)
      ..write(obj.createdAt)
      ..writeByte(7)
      ..write(obj.updatedAt)
      ..writeByte(8)
      ..write(obj.syncStatus);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IncomeDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_IncomeDto _$IncomeDtoFromJson(Map<String, dynamic> json) => _IncomeDto(
  id: json['id'] as String,
  userId: json['userId'] as String,
  accountId: json['accountId'] as String,
  amount: (json['amount'] as num).toDouble(),
  source: $enumDecode(_$IncomeSourceEnumMap, json['source']),
  description: json['description'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  syncStatus:
      $enumDecodeNullable(_$SyncStatusEnumMap, json['syncStatus']) ??
      SyncStatus.pending,
);

Map<String, dynamic> _$IncomeDtoToJson(_IncomeDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'accountId': instance.accountId,
      'amount': instance.amount,
      'source': _$IncomeSourceEnumMap[instance.source]!,
      'description': instance.description,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'syncStatus': _$SyncStatusEnumMap[instance.syncStatus]!,
    };

const _$IncomeSourceEnumMap = {
  IncomeSource.salary: 'salary',
  IncomeSource.freelance: 'freelance',
  IncomeSource.investment: 'investment',
  IncomeSource.business: 'business',
  IncomeSource.rental: 'rental',
  IncomeSource.gift: 'gift',
  IncomeSource.refund: 'refund',
  IncomeSource.other: 'other',
};

const _$SyncStatusEnumMap = {
  SyncStatus.synced: 'synced',
  SyncStatus.pending: 'pending',
  SyncStatus.failed: 'failed',
};
