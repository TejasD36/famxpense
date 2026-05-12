import '../../../../core.dart';

extension UserDtoMapper on UserDto {
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

extension UserEntityMapper on UserEntity {
  UserDto toDto() {
    return UserDto(
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
