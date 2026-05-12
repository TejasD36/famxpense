import '../../../core.dart';

part 'group_entity.freezed.dart';
part 'group_entity.g.dart';

@freezed
sealed class GroupEntity with _$GroupEntity {
  const factory GroupEntity({
    required String id,
    required String title,
    String? description,
    required String createdBy,
    required List<String> memberIds,
    required DateTime createdAt,
    DateTime? closedAt,
    @Default(false) bool isClosed,
  }) = _GroupEntity;

  factory GroupEntity.fromJson(Map<String, dynamic> json) => _$GroupEntityFromJson(json);
}
