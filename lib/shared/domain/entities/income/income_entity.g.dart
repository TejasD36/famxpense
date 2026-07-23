// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'income_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_IncomeEntity _$IncomeEntityFromJson(Map<String, dynamic> json) =>
    _IncomeEntity(
      id: json['id'] as String,
      userId: json['userId'] as String,
      accountId: json['accountId'] as String,
      amount: (json['amount'] as num).toDouble(),
      source: $enumDecode(_$IncomeSourceEnumMap, json['source']),
      description: json['description'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$IncomeEntityToJson(_IncomeEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'accountId': instance.accountId,
      'amount': instance.amount,
      'source': _$IncomeSourceEnumMap[instance.source]!,
      'description': instance.description,
      'createdAt': instance.createdAt.toIso8601String(),
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
