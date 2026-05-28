// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_remote_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExpenseRemoteDto _$ExpenseRemoteDtoFromJson(Map<String, dynamic> json) =>
    _ExpenseRemoteDto(
      id: json['id'] as String,
      title: json['title'] as String,
      note: json['note'] as String?,
      amount: (json['amount'] as num).toDouble(),
      paidByUserId: json['paidByUserId'] as String,
      ownerUserId: json['ownerUserId'] as String,
      expenseType: json['expenseType'] as String,
      splitType: json['splitType'] as String,
      participants: (json['participants'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
      participantIds: (json['participantIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      groupId: json['groupId'] as String?,
      accountId: json['accountId'] as String?,
      expenseDate: DateTime.parse(json['expenseDate'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      isDisabled: json['isDisabled'] as bool? ?? false,
    );

Map<String, dynamic> _$ExpenseRemoteDtoToJson(_ExpenseRemoteDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'note': instance.note,
      'amount': instance.amount,
      'paidByUserId': instance.paidByUserId,
      'ownerUserId': instance.ownerUserId,
      'expenseType': instance.expenseType,
      'splitType': instance.splitType,
      'participants': instance.participants,
      'participantIds': instance.participantIds,
      'groupId': instance.groupId,
      'accountId': instance.accountId,
      'expenseDate': instance.expenseDate.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'isDisabled': instance.isDisabled,
    };
