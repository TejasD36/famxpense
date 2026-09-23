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
        return ExpenseCategory.groceries;
      case 2:
        return ExpenseCategory.transport;
      case 3:
        return ExpenseCategory.shopping;
      case 4:
        return ExpenseCategory.healthFitness;
      case 5:
        return ExpenseCategory.entertainment;
      case 6:
        return ExpenseCategory.bills;
      case 7:
        return ExpenseCategory.rentHousing;
      case 8:
        return ExpenseCategory.travel;
      case 9:
        return ExpenseCategory.education;
      case 10:
        return ExpenseCategory.gifts;
      case 11:
        return ExpenseCategory.personalCare;
      case 12:
        return ExpenseCategory.subscriptions;
      case 13:
        return ExpenseCategory.work;
      case 14:
        return ExpenseCategory.pets;
      case 15:
        return ExpenseCategory.investments;
      case 16:
        return ExpenseCategory.household;
      case 17:
        return ExpenseCategory.other;
      default:
        return ExpenseCategory.food;
    }
  }

  @override
  void write(BinaryWriter writer, ExpenseCategory obj) {
    switch (obj) {
      case ExpenseCategory.food:
        writer.writeByte(0);
      case ExpenseCategory.groceries:
        writer.writeByte(1);
      case ExpenseCategory.transport:
        writer.writeByte(2);
      case ExpenseCategory.shopping:
        writer.writeByte(3);
      case ExpenseCategory.healthFitness:
        writer.writeByte(4);
      case ExpenseCategory.entertainment:
        writer.writeByte(5);
      case ExpenseCategory.bills:
        writer.writeByte(6);
      case ExpenseCategory.rentHousing:
        writer.writeByte(7);
      case ExpenseCategory.travel:
        writer.writeByte(8);
      case ExpenseCategory.education:
        writer.writeByte(9);
      case ExpenseCategory.gifts:
        writer.writeByte(10);
      case ExpenseCategory.personalCare:
        writer.writeByte(11);
      case ExpenseCategory.subscriptions:
        writer.writeByte(12);
      case ExpenseCategory.work:
        writer.writeByte(13);
      case ExpenseCategory.pets:
        writer.writeByte(14);
      case ExpenseCategory.investments:
        writer.writeByte(15);
      case ExpenseCategory.household:
        writer.writeByte(16);
      case ExpenseCategory.other:
        writer.writeByte(17);
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
