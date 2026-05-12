import '../../../../core.dart';

extension GroupDtoMapper on GroupDto {
  GroupEntity toEntity() {
    return GroupEntity(
      id: id,
      title: title,
      description: description,
      createdBy: createdBy,
      memberIds: memberIds,
      createdAt: createdAt,
      closedAt: closedAt,
      isClosed: isClosed,
    );
  }
}

extension GroupEntityMapper on GroupEntity {
  GroupDto toDto() {
    return GroupDto(
      id: id,
      title: title,
      description: description,
      createdBy: createdBy,
      memberIds: memberIds,
      createdAt: createdAt,
      closedAt: closedAt,
      isClosed: isClosed,
    );
  }
}
