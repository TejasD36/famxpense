import '../../../../core.dart';

part 'group_dto.freezed.dart';
part 'group_dto.g.dart';

@HiveType(typeId: HiveTypeIds.group)
@freezed
sealed class GroupDto with _$GroupDto {
  const factory GroupDto({
    @HiveField(0) required String id,
    @HiveField(1) required String title,
    @HiveField(2) String? description,
    @HiveField(3) required String createdBy,
    @HiveField(4) required List<String> memberIds,
    @HiveField(5) required DateTime createdAt,
    @HiveField(6) DateTime? closedAt,
    @HiveField(7) @Default(false) bool isClosed,
  }) = _GroupDto;

  factory GroupDto.fromJson(Map<String, dynamic> json) => _$GroupDtoFromJson(json);
}
