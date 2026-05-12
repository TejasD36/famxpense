// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpenseDtoAdapter extends TypeAdapter<ExpenseDto> {
  @override
  final typeId = 1;

  @override
  ExpenseDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExpenseDto(
      id: fields[0] as String,
      title: fields[1] as String,
      note: fields[2] as String?,
      amount: (fields[3] as num).toDouble(),
      paidByUserId: fields[4] as String,
      expenseType: fields[5] as ExpenseType,
      splitType: fields[6] as SplitType,
      participants: (fields[7] as List).cast<ExpenseParticipantDto>(),
      groupId: fields[8] as String?,
      accountId: fields[9] as String?,
      expenseDate: fields[10] as DateTime,
      createdAt: fields[11] as DateTime,
      updatedAt: fields[12] as DateTime,
      syncStatus: fields[13] as SyncStatus,
      isDisabled: fields[14] == null ? false : fields[14] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ExpenseDto obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.note)
      ..writeByte(3)
      ..write(obj.amount)
      ..writeByte(4)
      ..write(obj.paidByUserId)
      ..writeByte(5)
      ..write(obj.expenseType)
      ..writeByte(6)
      ..write(obj.splitType)
      ..writeByte(7)
      ..write(obj.participants)
      ..writeByte(8)
      ..write(obj.groupId)
      ..writeByte(9)
      ..write(obj.accountId)
      ..writeByte(10)
      ..write(obj.expenseDate)
      ..writeByte(11)
      ..write(obj.createdAt)
      ..writeByte(12)
      ..write(obj.updatedAt)
      ..writeByte(13)
      ..write(obj.syncStatus)
      ..writeByte(14)
      ..write(obj.isDisabled);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExpenseDto _$ExpenseDtoFromJson(Map<String, dynamic> json) => _ExpenseDto(
  id: json['id'] as String,
  title: json['title'] as String,
  note: json['note'] as String?,
  amount: (json['amount'] as num).toDouble(),
  paidByUserId: json['paidByUserId'] as String,
  expenseType: $enumDecode(_$ExpenseTypeEnumMap, json['expenseType']),
  splitType: $enumDecode(_$SplitTypeEnumMap, json['splitType']),
  participants: (json['participants'] as List<dynamic>)
      .map((e) => ExpenseParticipantDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  groupId: json['groupId'] as String?,
  accountId: json['accountId'] as String?,
  expenseDate: DateTime.parse(json['expenseDate'] as String),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  syncStatus: $enumDecode(_$SyncStatusEnumMap, json['syncStatus']),
  isDisabled: json['isDisabled'] as bool? ?? false,
);

Map<String, dynamic> _$ExpenseDtoToJson(_ExpenseDto instance) =>
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
