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
      participantIds:
          (json['participantIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
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

Map<String, dynamic> _$DebtLedgerEntityToJson(_DebtLedgerEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userA': instance.userA,
      'userB': instance.userB,
      'netBalance': instance.netBalance,
      'updatedAt': instance.updatedAt.toIso8601String(),
      'participantIds': instance.participantIds,
      'pendingMutations': instance.pendingMutations,
      'appliedMutationIds': instance.appliedMutationIds,
    };
