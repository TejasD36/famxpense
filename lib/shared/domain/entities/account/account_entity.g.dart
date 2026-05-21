// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AccountEntity _$AccountEntityFromJson(Map<String, dynamic> json) =>
    _AccountEntity(
      id: json['id'] as String,
      userId: json['userId'] as String,
      accountName: json['accountName'] as String,
      accountType: $enumDecode(_$AccountTypeEnumMap, json['accountType']),
      currentBalance: (json['currentBalance'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      isArchived: json['isArchived'] as bool? ?? false,
    );

Map<String, dynamic> _$AccountEntityToJson(_AccountEntity instance) =>
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
