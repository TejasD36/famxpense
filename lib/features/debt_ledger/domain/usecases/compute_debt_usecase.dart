import '../../xcore.dart';

class ComputeDebtUsecase {
  final DebtLedgerRepository _repository;

  ComputeDebtUsecase({required DebtLedgerRepository repository})
    : _repository = repository;

  Future<void> call({
    required String paidByUserId,
    required List<ExpenseParticipantEntity> participants,
    required double totalAmount,
    String? mutationIdPrefix,
  }) async {
    for (final participant in participants) {
      if (participant.userId == paidByUserId) continue;

      /// Participant owes their share to the payer
      await _repository.updateDebt(
        paidByUserId,
        participant.userId,
        -participant.amount,
        mutationId: mutationIdPrefix == null
            ? null
            : '$mutationIdPrefix-${participant.userId}',
      );
    }
  }
}
