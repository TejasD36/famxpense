import '../../../xcore.dart';

extension PartnershipRemoteMapper on PartnershipEntity {
  PartnershipRemoteDto toRemoteDto() {
    return PartnershipRemoteDto(
      id: id,

      senderId: senderId,

      receiverId: receiverId,

      senderEmail: senderEmail,

      receiverEmail: receiverEmail,

      senderNickname: senderNickname,
      receiverNickname: receiverNickname,

      status: status.name,

      createdAt: createdAt,

      updatedAt: updatedAt,
      participantIds: [senderId, receiverId],
    );
  }
}

extension PartnershipRemoteDtoMapper on PartnershipRemoteDto {
  PartnershipEntity toEntity() {
    return PartnershipEntity(
      id: id,

      senderId: senderId,

      receiverId: receiverId,

      senderEmail: senderEmail,

      receiverEmail: receiverEmail,
      senderNickname: senderNickname,
      receiverNickname: receiverNickname,

      status: PartnershipStatus.values.where((e) => e.name == status).firstOrNull ?? PartnershipStatus.pending,

      createdAt: createdAt,

      updatedAt: updatedAt,
    );
  }
}
