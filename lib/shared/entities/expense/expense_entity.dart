import '../../../core.dart';

part 'expense_entity.freezed.dart';
part 'expense_entity.g.dart';

@freezed
sealed class ExpenseEntity with _$ExpenseEntity {
  const factory ExpenseEntity({
    required String id,
    required String title,
    String? note,
    required double amount,
    required String paidByUserId,
    required ExpenseType expenseType,
    required SplitType splitType,
    required List<ExpenseParticipantEntity> participants,
    String? groupId,
    String? accountId,
    required DateTime expenseDate,
    required DateTime createdAt,
    required DateTime updatedAt,
    required SyncStatus syncStatus,
    @Default(false) bool isDisabled,
  }) = _ExpenseEntity;

  factory ExpenseEntity.fromJson(Map<String, dynamic> json) => _$ExpenseEntityFromJson(json);
}
