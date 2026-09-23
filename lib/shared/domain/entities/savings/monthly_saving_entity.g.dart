// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monthly_saving_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MonthlySavingEntity _$MonthlySavingEntityFromJson(Map<String, dynamic> json) =>
    _MonthlySavingEntity(
      id: json['id'] as String,
      accountId: json['accountId'] as String,
      year: (json['year'] as num).toInt(),
      month: (json['month'] as num).toInt(),
      goalAmount: (json['goalAmount'] as num).toDouble(),
      savedAmount: (json['savedAmount'] as num).toDouble(),
      openingBalance: (json['openingBalance'] as num).toDouble(),
      closingBalance: (json['closingBalance'] as num).toDouble(),
      achievementPercent: (json['achievementPercent'] as num).toDouble(),
      isCompleted: json['isCompleted'] as bool? ?? false,
      userId: json['userId'] as String? ?? '',
      syncStatus:
          $enumDecodeNullable(_$SyncStatusEnumMap, json['syncStatus']) ??
          SyncStatus.synced,
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$MonthlySavingEntityToJson(
  _MonthlySavingEntity instance,
) => <String, dynamic>{
  'id': instance.id,
  'accountId': instance.accountId,
  'year': instance.year,
  'month': instance.month,
  'goalAmount': instance.goalAmount,
  'savedAmount': instance.savedAmount,
  'openingBalance': instance.openingBalance,
  'closingBalance': instance.closingBalance,
  'achievementPercent': instance.achievementPercent,
  'isCompleted': instance.isCompleted,
  'userId': instance.userId,
  'syncStatus': _$SyncStatusEnumMap[instance.syncStatus]!,
  'updatedAt': instance.updatedAt?.toIso8601String(),
};

const _$SyncStatusEnumMap = {
  SyncStatus.synced: 'synced',
  SyncStatus.pending: 'pending',
  SyncStatus.failed: 'failed',
};
