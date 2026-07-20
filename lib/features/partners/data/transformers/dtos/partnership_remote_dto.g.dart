// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partnership_remote_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PartnershipRemoteDto _$PartnershipRemoteDtoFromJson(
  Map<String, dynamic> json,
) => _PartnershipRemoteDto(
  id: json['id'] as String,
  senderId: json['senderId'] as String,
  receiverId: json['receiverId'] as String,
  senderEmail: json['senderEmail'] as String,
  receiverEmail: json['receiverEmail'] as String,
  senderNickname: json['senderNickname'] as String,
  receiverNickname: json['receiverNickname'] as String,
  status: json['status'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  participantIds:
      (json['participantIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
);

Map<String, dynamic> _$PartnershipRemoteDtoToJson(
  _PartnershipRemoteDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'senderId': instance.senderId,
  'receiverId': instance.receiverId,
  'senderEmail': instance.senderEmail,
  'receiverEmail': instance.receiverEmail,
  'senderNickname': instance.senderNickname,
  'receiverNickname': instance.receiverNickname,
  'status': instance.status,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'participantIds': instance.participantIds,
};
