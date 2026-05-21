// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_participant_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExpenseParticipantEntity _$ExpenseParticipantEntityFromJson(
  Map<String, dynamic> json,
) => _ExpenseParticipantEntity(
  userId: json['userId'] as String,
  amount: (json['amount'] as num).toDouble(),
  isSettled: json['isSettled'] as bool? ?? false,
  settledAt: json['settledAt'] == null
      ? null
      : DateTime.parse(json['settledAt'] as String),
);

Map<String, dynamic> _$ExpenseParticipantEntityToJson(
  _ExpenseParticipantEntity instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'amount': instance.amount,
  'isSettled': instance.isSettled,
  'settledAt': instance.settledAt?.toIso8601String(),
};
