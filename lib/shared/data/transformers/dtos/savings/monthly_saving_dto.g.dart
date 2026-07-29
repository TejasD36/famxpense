// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monthly_saving_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MonthlySavingDtoAdapter extends TypeAdapter<MonthlySavingDto> {
  @override
  final typeId = 21;

  @override
  MonthlySavingDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MonthlySavingDto(
      id: fields[0] as String,
      accountId: fields[1] as String,
      year: (fields[2] as num).toInt(),
      month: (fields[3] as num).toInt(),
      goalAmount: (fields[4] as num).toDouble(),
      savedAmount: (fields[5] as num).toDouble(),
      openingBalance: (fields[6] as num).toDouble(),
      closingBalance: (fields[7] as num).toDouble(),
      achievementPercent: (fields[8] as num).toDouble(),
      isCompleted: fields[9] == null ? false : fields[9] as bool,
      userId: fields[10] == null ? '' : fields[10] as String,
      syncStatus: fields[11] == null
          ? SyncStatus.synced
          : fields[11] as SyncStatus,
    );
  }

  @override
  void write(BinaryWriter writer, MonthlySavingDto obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.accountId)
      ..writeByte(2)
      ..write(obj.year)
      ..writeByte(3)
      ..write(obj.month)
      ..writeByte(4)
      ..write(obj.goalAmount)
      ..writeByte(5)
      ..write(obj.savedAmount)
      ..writeByte(6)
      ..write(obj.openingBalance)
      ..writeByte(7)
      ..write(obj.closingBalance)
      ..writeByte(8)
      ..write(obj.achievementPercent)
      ..writeByte(9)
      ..write(obj.isCompleted)
      ..writeByte(10)
      ..write(obj.userId)
      ..writeByte(11)
      ..write(obj.syncStatus);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MonthlySavingDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MonthlySavingDto _$MonthlySavingDtoFromJson(Map<String, dynamic> json) =>
    _MonthlySavingDto(
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
    );

Map<String, dynamic> _$MonthlySavingDtoToJson(_MonthlySavingDto instance) =>
    <String, dynamic>{
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
    };

const _$SyncStatusEnumMap = {
  SyncStatus.synced: 'synced',
  SyncStatus.pending: 'pending',
  SyncStatus.failed: 'failed',
};
