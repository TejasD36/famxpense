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
      isSavings: json['isSavings'] as bool? ?? false,
      monthlySavingsGoal:
          (json['monthlySavingsGoal'] as num?)?.toDouble() ?? 0.0,
      pendingBalanceMutations:
          (json['pendingBalanceMutations'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toDouble()),
          ) ??
          const {},
      appliedBalanceMutationIds:
          (json['appliedBalanceMutationIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      hasPendingMetadataChanges:
          json['hasPendingMetadataChanges'] as bool? ?? false,
      isDeleted: json['isDeleted'] as bool? ?? false,
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
      'isSavings': instance.isSavings,
      'monthlySavingsGoal': instance.monthlySavingsGoal,
      'pendingBalanceMutations': instance.pendingBalanceMutations,
      'appliedBalanceMutationIds': instance.appliedBalanceMutationIds,
      'hasPendingMetadataChanges': instance.hasPendingMetadataChanges,
      'isDeleted': instance.isDeleted,
    };

const _$AccountTypeEnumMap = {
  AccountType.bank: 'bank',
  AccountType.cash: 'cash',
  AccountType.creditCard: 'creditCard',
  AccountType.wallet: 'wallet',
};
