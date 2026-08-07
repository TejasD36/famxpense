import '../../../../../core.dart';

part 'user_remote_dto.freezed.dart';
part 'user_remote_dto.g.dart';

@freezed
sealed class UserRemoteDto with _$UserRemoteDto {
  const factory UserRemoteDto({
    required String id,

    required String name,

    required String nickname,

    required String email,

    String? profileImageUrl,

    required DateTime createdAt,

    required DateTime updatedAt,

    @Default(true) bool isActive,
  }) = _UserRemoteDto;

  factory UserRemoteDto.fromJson(Map<String, dynamic> json) =>
      _$UserRemoteDtoFromJson(json);
}
