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
      balanceApplied: fields[5] == null ? true : fields[5] as bool,
      userId: fields[6] == null ? '' : fields[6] as String,
      previousBalance: (fields[7] as num?)?.toDouble(),
      newBalance: (fields[8] as num?)?.toDouble(),
      isBalanceEdit: fields[9] == null ? false : fields[9] as bool,
      synced: fields[10] == null ? false : fields[10] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ManualDepositDto obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.accountId)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.balanceApplied)
      ..writeByte(6)
      ..write(obj.userId)
      ..writeByte(7)
      ..write(obj.previousBalance)
      ..writeByte(8)
      ..write(obj.newBalance)
      ..writeByte(9)
      ..write(obj.isBalanceEdit)
      ..writeByte(10)
      ..write(obj.synced);
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
      balanceApplied: json['balanceApplied'] as bool? ?? true,
      userId: json['userId'] as String? ?? '',
      previousBalance: (json['previousBalance'] as num?)?.toDouble(),
      newBalance: (json['newBalance'] as num?)?.toDouble(),
      isBalanceEdit: json['isBalanceEdit'] as bool? ?? false,
      synced: json['synced'] as bool? ?? false,
    );

Map<String, dynamic> _$ManualDepositDtoToJson(_ManualDepositDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'accountId': instance.accountId,
      'amount': instance.amount,
      'description': instance.description,
      'createdAt': instance.createdAt.toIso8601String(),
      'balanceApplied': instance.balanceApplied,
      'userId': instance.userId,
      'previousBalance': instance.previousBalance,
      'newBalance': instance.newBalance,
      'isBalanceEdit': instance.isBalanceEdit,
      'synced': instance.synced,
    };
