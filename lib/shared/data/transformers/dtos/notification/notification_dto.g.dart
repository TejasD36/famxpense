// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotificationDtoAdapter extends TypeAdapter<NotificationDto> {
  @override
  final typeId = 8;

  @override
  NotificationDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotificationDto(
      id: fields[0] as String,
      userId: fields[1] as String,
      type: fields[2] as NotificationType,
      title: fields[3] as String,
      message: fields[4] as String,
      relatedId: fields[5] as String?,
      createdAt: fields[6] as DateTime,
      isRead: fields[7] == null ? false : fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, NotificationDto obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.message)
      ..writeByte(5)
      ..write(obj.relatedId)
      ..writeByte(6)
      ..write(obj.createdAt)
      ..writeByte(7)
      ..write(obj.isRead);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationDto _$NotificationDtoFromJson(Map<String, dynamic> json) =>
    _NotificationDto(
      id: json['id'] as String,
      userId: json['userId'] as String,
      type: $enumDecode(_$NotificationTypeEnumMap, json['type']),
      title: json['title'] as String,
      message: json['message'] as String,
      relatedId: json['relatedId'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      isRead: json['isRead'] as bool? ?? false,
    );

Map<String, dynamic> _$NotificationDtoToJson(_NotificationDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'type': _$NotificationTypeEnumMap[instance.type]!,
      'title': instance.title,
      'message': instance.message,
      'relatedId': instance.relatedId,
      'createdAt': instance.createdAt.toIso8601String(),
      'isRead': instance.isRead,
    };

const _$NotificationTypeEnumMap = {
  NotificationType.partnerRequest: 'partnerRequest',
  NotificationType.expenseAdded: 'expenseAdded',
  NotificationType.settlementRequest: 'settlementRequest',
  NotificationType.settlementConfirmed: 'settlementConfirmed',
  NotificationType.settlementRejected: 'settlementRejected',
};
