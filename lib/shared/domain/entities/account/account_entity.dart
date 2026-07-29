import '../../../../core.dart';

part 'account_entity.freezed.dart';
part 'account_entity.g.dart';

@freezed
sealed class AccountEntity with _$AccountEntity {
  const factory AccountEntity({
    required String id,
    required String userId,
    required String accountName,
    required AccountType accountType,
    required double currentBalance,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(false) bool isArchived,
    @Default(false) bool isSavings,
    @Default(0.0) double monthlySavingsGoal,
  }) = _AccountEntity;

  factory AccountEntity.fromJson(Map<String, dynamic> json) => _$AccountEntityFromJson(json);
}
