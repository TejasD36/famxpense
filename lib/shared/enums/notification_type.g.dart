// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotificationTypeAdapter extends TypeAdapter<NotificationType> {
  @override
  final typeId = 15;

  @override
  NotificationType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return NotificationType.partnerRequest;
      case 1:
        return NotificationType.expenseAdded;
      case 2:
        return NotificationType.settlementRequest;
      case 3:
        return NotificationType.settlementConfirmed;
      case 4:
        return NotificationType.settlementRejected;
      default:
        return NotificationType.partnerRequest;
    }
  }

  @override
  void write(BinaryWriter writer, NotificationType obj) {
    switch (obj) {
      case NotificationType.partnerRequest:
        writer.writeByte(0);
      case NotificationType.expenseAdded:
        writer.writeByte(1);
      case NotificationType.settlementRequest:
        writer.writeByte(2);
      case NotificationType.settlementConfirmed:
        writer.writeByte(3);
      case NotificationType.settlementRejected:
        writer.writeByte(4);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
