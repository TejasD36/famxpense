// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_category.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpenseCategoryAdapter extends TypeAdapter<ExpenseCategory> {
  @override
  final typeId = 18;

  @override
  ExpenseCategory read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ExpenseCategory.food;
      case 1:
        return ExpenseCategory.grocery;
      case 2:
        return ExpenseCategory.clothes;
      case 3:
        return ExpenseCategory.essentials;
      case 4:
        return ExpenseCategory.medical;
      case 5:
        return ExpenseCategory.snacks;
      case 6:
        return ExpenseCategory.lunch;
      case 7:
        return ExpenseCategory.dinner;
      case 8:
        return ExpenseCategory.movie;
      case 9:
        return ExpenseCategory.traveling;
      case 10:
        return ExpenseCategory.gifts;
      case 11:
        return ExpenseCategory.insurance;
      case 12:
        return ExpenseCategory.emi;
      case 13:
        return ExpenseCategory.recharge;
      case 14:
        return ExpenseCategory.electricity;
      case 15:
        return ExpenseCategory.mobileBill;
      case 16:
        return ExpenseCategory.subscription;
      case 17:
        return ExpenseCategory.other;
      case 18:
        return ExpenseCategory.fruits;
      default:
        return ExpenseCategory.food;
    }
  }

  @override
  void write(BinaryWriter writer, ExpenseCategory obj) {
    switch (obj) {
      case ExpenseCategory.food:
        writer.writeByte(0);
      case ExpenseCategory.grocery:
        writer.writeByte(1);
      case ExpenseCategory.clothes:
        writer.writeByte(2);
      case ExpenseCategory.essentials:
        writer.writeByte(3);
      case ExpenseCategory.medical:
        writer.writeByte(4);
      case ExpenseCategory.snacks:
        writer.writeByte(5);
      case ExpenseCategory.lunch:
        writer.writeByte(6);
      case ExpenseCategory.dinner:
        writer.writeByte(7);
      case ExpenseCategory.movie:
        writer.writeByte(8);
      case ExpenseCategory.traveling:
        writer.writeByte(9);
      case ExpenseCategory.gifts:
        writer.writeByte(10);
      case ExpenseCategory.insurance:
        writer.writeByte(11);
      case ExpenseCategory.emi:
        writer.writeByte(12);
      case ExpenseCategory.recharge:
        writer.writeByte(13);
      case ExpenseCategory.electricity:
        writer.writeByte(14);
      case ExpenseCategory.mobileBill:
        writer.writeByte(15);
      case ExpenseCategory.subscription:
        writer.writeByte(16);
      case ExpenseCategory.other:
        writer.writeByte(17);
      case ExpenseCategory.fruits:
        writer.writeByte(18);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
