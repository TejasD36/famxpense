// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partnership_status.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PartnershipStatusAdapter extends TypeAdapter<PartnershipStatus> {
  @override
  final typeId = 16;

  @override
  PartnershipStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return PartnershipStatus.pending;
      case 1:
        return PartnershipStatus.accepted;
      case 2:
        return PartnershipStatus.rejected;
      default:
        return PartnershipStatus.pending;
    }
  }

  @override
  void write(BinaryWriter writer, PartnershipStatus obj) {
    switch (obj) {
      case PartnershipStatus.pending:
        writer.writeByte(0);
      case PartnershipStatus.accepted:
        writer.writeByte(1);
      case PartnershipStatus.rejected:
        writer.writeByte(2);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PartnershipStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
