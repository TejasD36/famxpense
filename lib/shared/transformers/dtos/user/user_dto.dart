import '../../../../core.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

@HiveType(typeId: HiveTypeIds.user)
@freezed
sealed class UserDto with _$UserDto {
  const factory UserDto({
    @HiveField(0) required String id,
    @HiveField(1) required String name,
    @HiveField(2) String? nickname,
    @HiveField(3) required String email,
    @HiveField(4) String? profileImageUrl,
    @HiveField(5) required DateTime createdAt,
    @HiveField(6) required DateTime updatedAt,
    @HiveField(7) @Default(true) bool isActive,
  }) = _UserDto;

  factory UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);
}
