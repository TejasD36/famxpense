import '../../../../core.dart';

part 'draft_expense_dto.freezed.dart';
part 'draft_expense_dto.g.dart';

@HiveType(typeId: HiveTypeIds.draftExpense)
@freezed
sealed class DraftExpenseDto with _$DraftExpenseDto {
  const factory DraftExpenseDto({
    @HiveField(0) required String userId,

    @HiveField(1) String? title,

    @HiveField(2) String? note,

    @HiveField(3) double? amount,

    @HiveField(4) DateTime? expenseDate,

    @HiveField(5) String? groupId,

    @HiveField(6) String? accountId,
    @HiveField(7) DateTime? updatedAt,
  }) = _DraftExpenseDto;

  factory DraftExpenseDto.fromJson(Map<String, dynamic> json) => _$DraftExpenseDtoFromJson(json);
}
