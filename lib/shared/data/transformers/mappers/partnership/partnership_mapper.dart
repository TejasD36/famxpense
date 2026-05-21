import '../../../../../core.dart';

extension PartnershipDtoMapper on PartnershipDto {
  PartnershipEntity toEntity() {
    return PartnershipEntity(
      id: id,

      senderId: senderId,

      senderEmail: senderEmail,

      senderNickname: senderNickname,

      receiverId: receiverId,

      receiverEmail: receiverEmail,

      receiverNickname: receiverNickname,

      status: status,

      createdAt: createdAt,

      updatedAt: updatedAt,
    );
  }
}

extension PartnershipEntityMapper on PartnershipEntity {
  PartnershipDto toDto() {
    return PartnershipDto(
      id: id,

      senderId: senderId,

      senderEmail: senderEmail,

      senderNickname: senderNickname,

      receiverId: receiverId,

      receiverEmail: receiverEmail,

      receiverNickname: receiverNickname,

      status: status,

      createdAt: createdAt,

      updatedAt: updatedAt,
    );
  }
}
