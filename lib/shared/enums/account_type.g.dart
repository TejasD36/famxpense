// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AccountTypeAdapter extends TypeAdapter<AccountType> {
  @override
  final typeId = 13;

  @override
  AccountType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return AccountType.bank;
      case 1:
        return AccountType.cash;
      case 2:
        return AccountType.creditCard;
      case 3:
        return AccountType.wallet;
      default:
        return AccountType.bank;
    }
  }

  @override
  void write(BinaryWriter writer, AccountType obj) {
    switch (obj) {
      case AccountType.bank:
        writer.writeByte(0);
      case AccountType.cash:
        writer.writeByte(1);
      case AccountType.creditCard:
        writer.writeByte(2);
      case AccountType.wallet:
        writer.writeByte(3);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
