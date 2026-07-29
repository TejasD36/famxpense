import '../../../../../core.dart';

part 'transfer_dto.freezed.dart';
part 'transfer_dto.g.dart';

@HiveType(typeId: HiveTypeIds.transfer)
@freezed
sealed class TransferDto with _$TransferDto {
  const factory TransferDto({
    @HiveField(0) required String id,
    @HiveField(1) required String fromAccountId,
    @HiveField(2) required String toAccountId,
    @HiveField(3) required String fromUserId,
    @HiveField(4) required String toUserId,
    @HiveField(5) required double amount,
    @HiveField(6) required String description,
    @HiveField(7) required DateTime createdAt,
    @HiveField(8) required DateTime updatedAt,
    @HiveField(9) @Default(SyncStatus.synced) SyncStatus syncStatus,
  }) = _TransferDto;

  factory TransferDto.fromJson(Map<String, dynamic> json) => _$TransferDtoFromJson(json);
}
