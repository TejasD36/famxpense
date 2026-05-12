// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GroupEntity _$GroupEntityFromJson(Map<String, dynamic> json) => _GroupEntity(
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

Map<String, dynamic> _$GroupEntityToJson(_GroupEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'createdBy': instance.createdBy,
      'memberIds': instance.memberIds,
      'createdAt': instance.createdAt.toIso8601String(),
      'closedAt': instance.closedAt?.toIso8601String(),
      'isClosed': instance.isClosed,
    };
