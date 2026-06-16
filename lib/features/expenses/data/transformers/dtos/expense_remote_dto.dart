import '../../../xcore.dart';

part 'expense_remote_dto.freezed.dart';
part 'expense_remote_dto.g.dart';

@freezed
sealed class ExpenseRemoteDto with _$ExpenseRemoteDto {
  const factory ExpenseRemoteDto({
    required String id,
    required String title,
    String? note,
    required double amount,
    required String paidByUserId,
    required String ownerUserId,
    required String expenseType,
    required String splitType,
    required List<Map<String, dynamic>> participants,
    required List<String> participantIds,
    String? groupId,
    String? accountId,
    required DateTime expenseDate,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(false) bool isDisabled,
    String? category,
  }) = _ExpenseRemoteDto;

  factory ExpenseRemoteDto.fromJson(Map<String, dynamic> json) => _$ExpenseRemoteDtoFromJson(json);
}
