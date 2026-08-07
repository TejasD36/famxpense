import '../../../../core.dart';

part 'transfer_entity.freezed.dart';
part 'transfer_entity.g.dart';

@freezed
sealed class TransferEntity with _$TransferEntity {
  const factory TransferEntity({
    required String id,
    required String fromAccountId,
    required String toAccountId,
    required String fromUserId,
    required String toUserId,
    required double amount,
    required String description,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(SyncStatus.synced) SyncStatus syncStatus,
  }) = _TransferEntity;

  factory TransferEntity.fromJson(Map<String, dynamic> json) =>
      _$TransferEntityFromJson(json);
}
