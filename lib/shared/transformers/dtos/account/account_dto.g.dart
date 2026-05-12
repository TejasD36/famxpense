// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AccountDtoAdapter extends TypeAdapter<AccountDto> {
  @override
  final typeId = 3;

  @override
  AccountDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AccountDto(
      id: fields[0] as String,
      userId: fields[1] as String,
      accountName: fields[2] as String,
      accountType: fields[3] as AccountType,
      currentBalance: (fields[4] as num).toDouble(),
      createdAt: fields[5] as DateTime,
      updatedAt: fields[6] as DateTime,
      isArchived: fields[7] == null ? false : fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, AccountDto obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.accountName)
      ..writeByte(3)
      ..write(obj.accountType)
      ..writeByte(4)
      ..write(obj.currentBalance)
      ..writeByte(5)
      ..write(obj.createdAt)
      ..writeByte(6)
      ..write(obj.updatedAt)
      ..writeByte(7)
      ..write(obj.isArchived);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AccountDto _$AccountDtoFromJson(Map<String, dynamic> json) => _AccountDto(
  id: json['id'] as String,
  userId: json['userId'] as String,
  accountName: json['accountName'] as String,
  accountType: $enumDecode(_$AccountTypeEnumMap, json['accountType']),
  currentBalance: (json['currentBalance'] as num).toDouble(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  isArchived: json['isArchived'] as bool? ?? false,
);

Map<String, dynamic> _$AccountDtoToJson(_AccountDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'accountName': instance.accountName,
      'accountType': _$AccountTypeEnumMap[instance.accountType]!,
      'currentBalance': instance.currentBalance,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'isArchived': instance.isArchived,
    };

const _$AccountTypeEnumMap = {
  AccountType.bank: 'bank',
  AccountType.cash: 'cash',
  AccountType.creditCard: 'creditCard',
  AccountType.wallet: 'wallet',
};
