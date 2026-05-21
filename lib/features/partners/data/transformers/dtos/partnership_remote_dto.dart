import '../../../xcore.dart';

part 'partnership_remote_dto.freezed.dart';
part 'partnership_remote_dto.g.dart';

@freezed
sealed class PartnershipRemoteDto with _$PartnershipRemoteDto {
  const factory PartnershipRemoteDto({
    required String id,

    required String senderId,

    required String receiverId,

    required String senderEmail,

    required String receiverEmail,

    required String senderNickname,

    required String receiverNickname,

    required String status,

    required DateTime createdAt,

    required DateTime updatedAt,
  }) = _PartnershipRemoteDto;

  factory PartnershipRemoteDto.fromJson(Map<String, dynamic> json) => _$PartnershipRemoteDtoFromJson(json);
}
