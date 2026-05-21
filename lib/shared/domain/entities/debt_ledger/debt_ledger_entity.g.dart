// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debt_ledger_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DebtLedgerEntity _$DebtLedgerEntityFromJson(Map<String, dynamic> json) =>
    _DebtLedgerEntity(
      id: json['id'] as String,
      userA: json['userA'] as String,
      userB: json['userB'] as String,
      netBalance: (json['netBalance'] as num).toDouble(),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$DebtLedgerEntityToJson(_DebtLedgerEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userA': instance.userA,
      'userB': instance.userB,
      'netBalance': instance.netBalance,
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
