// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'draft_expense_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DraftExpenseDtoAdapter extends TypeAdapter<DraftExpenseDto> {
  @override
  final typeId = 9;

  @override
  DraftExpenseDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DraftExpenseDto(
      userId: fields[0] as String,
      title: fields[1] as String?,
      note: fields[2] as String?,
      amount: (fields[3] as num?)?.toDouble(),
      expenseDate: fields[4] as DateTime?,
      groupId: fields[5] as String?,
      accountId: fields[6] as String?,
      updatedAt: fields[7] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, DraftExpenseDto obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.note)
      ..writeByte(3)
      ..write(obj.amount)
      ..writeByte(4)
      ..write(obj.expenseDate)
      ..writeByte(5)
      ..write(obj.groupId)
      ..writeByte(6)
      ..write(obj.accountId)
      ..writeByte(7)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DraftExpenseDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DraftExpenseDto _$DraftExpenseDtoFromJson(Map<String, dynamic> json) =>
    _DraftExpenseDto(
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

Map<String, dynamic> _$DraftExpenseDtoToJson(_DraftExpenseDto instance) =>
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
