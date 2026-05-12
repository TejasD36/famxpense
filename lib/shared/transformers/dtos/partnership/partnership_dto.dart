import '../../../../core.dart';

part 'partnership_dto.freezed.dart';
part 'partnership_dto.g.dart';

@HiveType(typeId: HiveTypeIds.partnership)
@freezed
sealed class PartnershipDto with _$PartnershipDto {
  const factory PartnershipDto({
    @HiveField(0) required String id,
    @HiveField(1) required String userA,
    @HiveField(2) required String userB,
    @HiveField(3) required DateTime createdAt,
    @HiveField(4) @Default(false) bool isAccepted,
  }) = _PartnershipDto;

  factory PartnershipDto.fromJson(Map<String, dynamic> json) => _$PartnershipDtoFromJson(json);
}
