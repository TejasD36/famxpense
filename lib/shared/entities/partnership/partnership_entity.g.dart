// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partnership_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PartnershipEntity _$PartnershipEntityFromJson(Map<String, dynamic> json) =>
    _PartnershipEntity(
      id: json['id'] as String,
      userA: json['userA'] as String,
      userB: json['userB'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      isAccepted: json['isAccepted'] as bool? ?? false,
    );

Map<String, dynamic> _$PartnershipEntityToJson(_PartnershipEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userA': instance.userA,
      'userB': instance.userB,
      'createdAt': instance.createdAt.toIso8601String(),
      'isAccepted': instance.isAccepted,
    };
