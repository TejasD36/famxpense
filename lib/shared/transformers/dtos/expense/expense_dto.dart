import '../../../../core.dart';

part 'expense_dto.freezed.dart';
part 'expense_dto.g.dart';

@HiveType(typeId: HiveTypeIds.expense)
@freezed
sealed class ExpenseDto with _$ExpenseDto {
  const factory ExpenseDto({
    @HiveField(0) required String id,
    @HiveField(1) required String title,
    @HiveField(2) String? note,
    @HiveField(3) required double amount,
    @HiveField(4) required String paidByUserId,
    @HiveField(5) required ExpenseType expenseType,
    @HiveField(6) required SplitType splitType,
    @HiveField(7) required List<ExpenseParticipantDto> participants,
    @HiveField(8) String? groupId,
    @HiveField(9) String? accountId,
    @HiveField(10) required DateTime expenseDate,
    @HiveField(11) required DateTime createdAt,
    @HiveField(12) required DateTime updatedAt,
    @HiveField(13) required SyncStatus syncStatus,
    @HiveField(14) @Default(false) bool isDisabled,
  }) = _ExpenseDto;

  factory ExpenseDto.fromJson(Map<String, dynamic> json) => _$ExpenseDtoFromJson(json);
}
