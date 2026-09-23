import '../../../../core.dart';

part 'income_entity.freezed.dart';
part 'income_entity.g.dart';

@freezed
sealed class IncomeEntity with _$IncomeEntity {
  const factory IncomeEntity({
    required String id,
    required String userId,
    required String accountId,
    required double amount,
    required IncomeSource source,
    required String description,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(SyncStatus.pending) SyncStatus syncStatus,
    @Default(false) bool isDeleted,
  }) = _IncomeEntity;

  factory IncomeEntity.fromJson(Map<String, dynamic> json) =>
      _$IncomeEntityFromJson(json);
}
