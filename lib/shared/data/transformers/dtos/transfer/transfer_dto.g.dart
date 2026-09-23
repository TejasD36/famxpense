// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransferDtoAdapter extends TypeAdapter<TransferDto> {
  @override
  final typeId = 22;

  @override
  TransferDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransferDto(
      id: fields[0] as String,
      fromAccountId: fields[1] as String,
      toAccountId: fields[2] as String,
      fromUserId: fields[3] as String,
      toUserId: fields[4] as String,
      amount: (fields[5] as num).toDouble(),
      description: fields[6] as String,
      createdAt: fields[7] as DateTime,
      updatedAt: fields[8] as DateTime,
      syncStatus: fields[9] == null
          ? SyncStatus.synced
          : fields[9] as SyncStatus,
    );
  }

  @override
  void write(BinaryWriter writer, TransferDto obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.fromAccountId)
      ..writeByte(2)
      ..write(obj.toAccountId)
      ..writeByte(3)
      ..write(obj.fromUserId)
      ..writeByte(4)
      ..write(obj.toUserId)
      ..writeByte(5)
      ..write(obj.amount)
      ..writeByte(6)
      ..write(obj.description)
      ..writeByte(7)
      ..write(obj.createdAt)
      ..writeByte(8)
      ..write(obj.updatedAt)
      ..writeByte(9)
      ..write(obj.syncStatus);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransferDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TransferDto _$TransferDtoFromJson(Map<String, dynamic> json) => _TransferDto(
  id: json['id'] as String,
  fromAccountId: json['fromAccountId'] as String,
  toAccountId: json['toAccountId'] as String,
  fromUserId: json['fromUserId'] as String,
  toUserId: json['toUserId'] as String,
  amount: (json['amount'] as num).toDouble(),
  description: json['description'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  syncStatus:
      $enumDecodeNullable(_$SyncStatusEnumMap, json['syncStatus']) ??
      SyncStatus.synced,
);

Map<String, dynamic> _$TransferDtoToJson(_TransferDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fromAccountId': instance.fromAccountId,
      'toAccountId': instance.toAccountId,
      'fromUserId': instance.fromUserId,
      'toUserId': instance.toUserId,
      'amount': instance.amount,
      'description': instance.description,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'syncStatus': _$SyncStatusEnumMap[instance.syncStatus]!,
    };

const _$SyncStatusEnumMap = {
  SyncStatus.synced: 'synced',
  SyncStatus.pending: 'pending',
  SyncStatus.failed: 'failed',
};
