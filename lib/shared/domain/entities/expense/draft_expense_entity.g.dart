// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'draft_expense_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DraftExpenseEntity _$DraftExpenseEntityFromJson(Map<String, dynamic> json) =>
    _DraftExpenseEntity(
      userId: json['userId'] as String,
      title: json['title'] as String?,
      note: json['note'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      expenseDate: json['expenseDate'] == null
          ? null
          : DateTime.parse(json['expenseDate'] as String),
      groupId: json['groupId'] as String?,
      accountId: json['accountId'] as String?,
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$DraftExpenseEntityToJson(_DraftExpenseEntity instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'title': instance.title,
      'note': instance.note,
      'amount': instance.amount,
      'expenseDate': instance.expenseDate?.toIso8601String(),
      'groupId': instance.groupId,
      'accountId': instance.accountId,
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
