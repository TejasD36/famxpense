import '../../../core.dart';

part 'partnership_entity.freezed.dart';
part 'partnership_entity.g.dart';

@freezed
sealed class PartnershipEntity with _$PartnershipEntity {
  const factory PartnershipEntity({
    required String id,
    required String userA,
    required String userB,
    required DateTime createdAt,
    @Default(false) bool isAccepted,
  }) = _PartnershipEntity;

  factory PartnershipEntity.fromJson(Map<String, dynamic> json) => _$PartnershipEntityFromJson(json);
}
