import '../../../../core.dart';

part 'partnership_entity.freezed.dart';
part 'partnership_entity.g.dart';

@freezed
sealed class PartnershipEntity with _$PartnershipEntity {
  const factory PartnershipEntity({
    required String id,

    /// REQUEST OWNER
    required String senderId,

    required String senderEmail,

    required String senderNickname,

    /// REQUEST RECEIVER
    required String receiverId,

    required String receiverEmail,

    required String receiverNickname,

    /// STATUS
    required PartnershipStatus status,

    required DateTime createdAt,

    required DateTime updatedAt,
  }) = _PartnershipEntity;

  factory PartnershipEntity.fromJson(Map<String, dynamic> json) => _$PartnershipEntityFromJson(json);
}
