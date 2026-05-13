// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settlement_status.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SettlementStatusAdapter extends TypeAdapter<SettlementStatus> {
  @override
  final typeId = 14;

  @override
  SettlementStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return SettlementStatus.pending;
      case 1:
        return SettlementStatus.confirmed;
      case 2:
        return SettlementStatus.rejected;
      default:
        return SettlementStatus.pending;
    }
  }

  @override
  void write(BinaryWriter writer, SettlementStatus obj) {
    switch (obj) {
      case SettlementStatus.pending:
        writer.writeByte(0);
      case SettlementStatus.confirmed:
        writer.writeByte(1);
      case SettlementStatus.rejected:
        writer.writeByte(2);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettlementStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
