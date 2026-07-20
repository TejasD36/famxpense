import 'package:famxpense/features/debt_ledger/domain/usecases/compute_debt_usecase.dart';
import 'package:famxpense/shared/domain/entities/expense/expense_participant_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';

void main() {
  late MockDebtLedgerRepository repository;
  late ComputeDebtUsecase usecase;

  setUp(() {
    repository = MockDebtLedgerRepository();
    when(() => repository.updateDebt(any(), any(), any())).thenAnswer((_) async {});
    usecase = ComputeDebtUsecase(repository: repository);
  });

  group('ComputeDebtUsecase', () {
    test('skips payer and creates debt for each other participant', () async {
      const paidByUserId = 'user-payer';

      final participants = [
        ExpenseParticipantEntity(userId: 'user-payer', amount: 50.0),
        ExpenseParticipantEntity(userId: 'user-a', amount: 30.0),
        ExpenseParticipantEntity(userId: 'user-b', amount: 20.0),
      ];

      await usecase(paidByUserId: paidByUserId, participants: participants, totalAmount: 100.0);

      verify(() => repository.updateDebt('user-payer', 'user-a', -30.0)).called(1);
      verify(() => repository.updateDebt('user-payer', 'user-b', -20.0)).called(1);
      verifyNoMoreInteractions(repository);
    });

    test('handles single participant (user pays for self)', () async {
      const paidByUserId = 'user-payer';

      final participants = [
        ExpenseParticipantEntity(userId: 'user-payer', amount: 100.0),
      ];

      await usecase(paidByUserId: paidByUserId, participants: participants, totalAmount: 100.0);

      verifyZeroInteractions(repository);
    });

    test('handles many participants', () async {
      const paidByUserId = 'user-payer';

      final participants = [
        ExpenseParticipantEntity(userId: 'user-payer', amount: 100.0),
        ExpenseParticipantEntity(userId: 'user-a', amount: 25.0),
        ExpenseParticipantEntity(userId: 'user-b', amount: 25.0),
        ExpenseParticipantEntity(userId: 'user-c', amount: 25.0),
        ExpenseParticipantEntity(userId: 'user-d', amount: 25.0),
      ];

      await usecase(paidByUserId: paidByUserId, participants: participants, totalAmount: 200.0);

      verify(() => repository.updateDebt('user-payer', 'user-a', -25.0)).called(1);
      verify(() => repository.updateDebt('user-payer', 'user-b', -25.0)).called(1);
      verify(() => repository.updateDebt('user-payer', 'user-c', -25.0)).called(1);
      verify(() => repository.updateDebt('user-payer', 'user-d', -25.0)).called(1);
    });
  });
}
