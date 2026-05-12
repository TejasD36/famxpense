// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settlement_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SettlementEntity _$SettlementEntityFromJson(Map<String, dynamic> json) =>
    _SettlementEntity(
      id: json['id'] as String,
      fromUserId: json['fromUserId'] as String,
      toUserId: json['toUserId'] as String,
      amount: (json['amount'] as num).toDouble(),
      status: $enumDecode(_$SettlementStatusEnumMap, json['status']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      confirmedAt: json['confirmedAt'] == null
          ? null
          : DateTime.parse(json['confirmedAt'] as String),
      relatedExpenseIds: (json['relatedExpenseIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$SettlementEntityToJson(_SettlementEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fromUserId': instance.fromUserId,
      'toUserId': instance.toUserId,
      'amount': instance.amount,
      'status': _$SettlementStatusEnumMap[instance.status]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'confirmedAt': instance.confirmedAt?.toIso8601String(),
      'relatedExpenseIds': instance.relatedExpenseIds,
    };

const _$SettlementStatusEnumMap = {
  SettlementStatus.pending: 'pending',
  SettlementStatus.confirmed: 'confirmed',
  SettlementStatus.rejected: 'rejected',
};
