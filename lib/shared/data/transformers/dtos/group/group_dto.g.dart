// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GroupDtoAdapter extends TypeAdapter<GroupDto> {
  @override
  final typeId = 4;

  @override
  GroupDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GroupDto(
      id: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String?,
      createdBy: fields[3] as String,
      memberIds: (fields[4] as List).cast<String>(),
      createdAt: fields[5] as DateTime,
      closedAt: fields[6] as DateTime?,
      isClosed: fields[7] == null ? false : fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, GroupDto obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.createdBy)
      ..writeByte(4)
      ..write(obj.memberIds)
      ..writeByte(5)
      ..write(obj.createdAt)
      ..writeByte(6)
      ..write(obj.closedAt)
      ..writeByte(7)
      ..write(obj.isClosed);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GroupDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GroupDto _$GroupDtoFromJson(Map<String, dynamic> json) => _GroupDto(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String?,
  createdBy: json['createdBy'] as String,
  memberIds: (json['memberIds'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  closedAt: json['closedAt'] == null
      ? null
      : DateTime.parse(json['closedAt'] as String),
  isClosed: json['isClosed'] as bool? ?? false,
);

Map<String, dynamic> _$GroupDtoToJson(_GroupDto instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'createdBy': instance.createdBy,
  'memberIds': instance.memberIds,
  'createdAt': instance.createdAt.toIso8601String(),
  'closedAt': instance.closedAt?.toIso8601String(),
  'isClosed': instance.isClosed,
};
