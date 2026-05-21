// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExpenseEntity _$ExpenseEntityFromJson(Map<String, dynamic> json) =>
    _ExpenseEntity(
      id: json['id'] as String,
      title: json['title'] as String,
      note: json['note'] as String?,
      amount: (json['amount'] as num).toDouble(),
      paidByUserId: json['paidByUserId'] as String,
      expenseType: $enumDecode(_$ExpenseTypeEnumMap, json['expenseType']),
      splitType: $enumDecode(_$SplitTypeEnumMap, json['splitType']),
      participants: (json['participants'] as List<dynamic>)
          .map(
            (e) => ExpenseParticipantEntity.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
      groupId: json['groupId'] as String?,
      accountId: json['accountId'] as String?,
      expenseDate: DateTime.parse(json['expenseDate'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      syncStatus: $enumDecode(_$SyncStatusEnumMap, json['syncStatus']),
      isDisabled: json['isDisabled'] as bool? ?? false,
    );

Map<String, dynamic> _$ExpenseEntityToJson(_ExpenseEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'note': instance.note,
      'amount': instance.amount,
      'paidByUserId': instance.paidByUserId,
      'expenseType': _$ExpenseTypeEnumMap[instance.expenseType]!,
      'splitType': _$SplitTypeEnumMap[instance.splitType]!,
      'participants': instance.participants,
      'groupId': instance.groupId,
      'accountId': instance.accountId,
      'expenseDate': instance.expenseDate.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'syncStatus': _$SyncStatusEnumMap[instance.syncStatus]!,
      'isDisabled': instance.isDisabled,
    };

const _$ExpenseTypeEnumMap = {
  ExpenseType.personal: 'personal',
  ExpenseType.shared: 'shared',
  ExpenseType.group: 'group',
};

const _$SplitTypeEnumMap = {
  SplitType.equal: 'equal',
  SplitType.manual: 'manual',
};

const _$SyncStatusEnumMap = {
  SyncStatus.synced: 'synced',
  SyncStatus.pending: 'pending',
  SyncStatus.failed: 'failed',
};
