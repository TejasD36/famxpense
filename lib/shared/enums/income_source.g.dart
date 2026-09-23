// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'income_source.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IncomeSourceAdapter extends TypeAdapter<IncomeSource> {
  @override
  final typeId = 19;

  @override
  IncomeSource read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return IncomeSource.salary;
      case 1:
        return IncomeSource.freelance;
      case 2:
        return IncomeSource.investment;
      case 3:
        return IncomeSource.business;
      case 4:
        return IncomeSource.rental;
      case 5:
        return IncomeSource.gift;
      case 6:
        return IncomeSource.refund;
      case 7:
        return IncomeSource.other;
      default:
        return IncomeSource.salary;
    }
  }

  @override
  void write(BinaryWriter writer, IncomeSource obj) {
    switch (obj) {
      case IncomeSource.salary:
        writer.writeByte(0);
      case IncomeSource.freelance:
        writer.writeByte(1);
      case IncomeSource.investment:
        writer.writeByte(2);
      case IncomeSource.business:
        writer.writeByte(3);
      case IncomeSource.rental:
        writer.writeByte(4);
      case IncomeSource.gift:
        writer.writeByte(5);
      case IncomeSource.refund:
        writer.writeByte(6);
      case IncomeSource.other:
        writer.writeByte(7);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IncomeSourceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
