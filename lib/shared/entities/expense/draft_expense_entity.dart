import '../../../core.dart';

part 'draft_expense_entity.freezed.dart';
part 'draft_expense_entity.g.dart';

@freezed
sealed class DraftExpenseEntity with _$DraftExpenseEntity {
  const factory DraftExpenseEntity({
    required String userId,
    String? title,
    String? note,
    double? amount,
    DateTime? expenseDate,
    String? groupId,
    String? accountId,
    DateTime? updatedAt,
  }) = _DraftExpenseEntity;

  factory DraftExpenseEntity.fromJson(Map<String, dynamic> json) => _$DraftExpenseEntityFromJson(json);
}
