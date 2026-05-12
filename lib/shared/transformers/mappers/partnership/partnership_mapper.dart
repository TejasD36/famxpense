import '../../../../core.dart';

extension PartnershipDtoMapper on PartnershipDto {
  PartnershipEntity toEntity() {
    return PartnershipEntity(id: id, userA: userA, userB: userB, createdAt: createdAt, isAccepted: isAccepted);
  }
}

extension PartnershipEntityMapper on PartnershipEntity {
  PartnershipDto toDto() {
    return PartnershipDto(id: id, userA: userA, userB: userB, createdAt: createdAt, isAccepted: isAccepted);
  }
}
