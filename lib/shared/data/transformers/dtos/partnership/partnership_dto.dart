import '../../../../../core.dart';

part 'partnership_dto.freezed.dart';
part 'partnership_dto.g.dart';

@HiveType(typeId: HiveTypeIds.partnership)
@freezed
sealed class PartnershipDto with _$PartnershipDto {
  const factory PartnershipDto({
    @HiveField(0) required String id,

    /// SENDER
    @HiveField(1) required String senderId,

    @HiveField(2) required String senderEmail,

    @HiveField(3) required String senderNickname,

    /// RECEIVER
    @HiveField(4) required String receiverId,

    @HiveField(5) required String receiverEmail,

    @HiveField(6) required String receiverNickname,

    /// STATUS
    @HiveField(7) required PartnershipStatus status,

    @HiveField(8) required DateTime createdAt,

    @HiveField(9) required DateTime updatedAt,
  }) = _PartnershipDto;

  factory PartnershipDto.fromJson(Map<String, dynamic> json) =>
      _$PartnershipDtoFromJson(json);
}
