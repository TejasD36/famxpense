import '../../../../../core.dart';

extension UserRemoteMapper on UserEntity {
  UserRemoteDto toRemoteDto() {
    return UserRemoteDto(
      id: id,

      name: name,

      nickname: nickname,

      email: email,

      profileImageUrl: profileImageUrl,

      createdAt: createdAt,

      updatedAt: updatedAt,

      isActive: isActive,
    );
  }
}

extension UserRemoteDtoMapper on UserRemoteDto {
  UserEntity toEntity() {
    return UserEntity(
      id: id,

      name: name,

      nickname: nickname,

      email: email,

      profileImageUrl: profileImageUrl,

      createdAt: createdAt,

      updatedAt: updatedAt,

      isActive: isActive,
    );
  }
}
