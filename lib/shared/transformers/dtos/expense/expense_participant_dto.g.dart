// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_participant_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpenseParticipantDtoAdapter extends TypeAdapter<ExpenseParticipantDto> {
  @override
  final typeId = 2;

  @override
  ExpenseParticipantDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExpenseParticipantDto(
      userId: fields[0] as String,
      amount: (fields[1] as num).toDouble(),
      isSettled: fields[2] == null ? false : fields[2] as bool,
      settledAt: fields[3] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, ExpenseParticipantDto obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.isSettled)
      ..writeByte(3)
      ..write(obj.settledAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseParticipantDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExpenseParticipantDto _$ExpenseParticipantDtoFromJson(
  Map<String, dynamic> json,
) => _ExpenseParticipantDto(
  userId: json['userId'] as String,
  amount: (json['amount'] as num).toDouble(),
  isSettled: json['isSettled'] as bool? ?? false,
  settledAt: json['settledAt'] == null
      ? null
      : DateTime.parse(json['settledAt'] as String),
);

Map<String, dynamic> _$ExpenseParticipantDtoToJson(
  _ExpenseParticipantDto instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'amount': instance.amount,
  'isSettled': instance.isSettled,
  'settledAt': instance.settledAt?.toIso8601String(),
};
