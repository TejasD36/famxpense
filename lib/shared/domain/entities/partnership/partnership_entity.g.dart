// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partnership_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PartnershipEntity _$PartnershipEntityFromJson(Map<String, dynamic> json) =>
    _PartnershipEntity(
      id: json['id'] as String,
      senderId: json['senderId'] as String,
      senderEmail: json['senderEmail'] as String,
      senderNickname: json['senderNickname'] as String,
      receiverId: json['receiverId'] as String,
      receiverEmail: json['receiverEmail'] as String,
      receiverNickname: json['receiverNickname'] as String,
      status: $enumDecode(_$PartnershipStatusEnumMap, json['status']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$PartnershipEntityToJson(_PartnershipEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'senderId': instance.senderId,
      'senderEmail': instance.senderEmail,
      'senderNickname': instance.senderNickname,
      'receiverId': instance.receiverId,
      'receiverEmail': instance.receiverEmail,
      'receiverNickname': instance.receiverNickname,
      'status': _$PartnershipStatusEnumMap[instance.status]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$PartnershipStatusEnumMap = {
  PartnershipStatus.pending: 'pending',
  PartnershipStatus.accepted: 'accepted',
  PartnershipStatus.rejected: 'rejected',
};
