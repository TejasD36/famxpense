import 'package:famxpense/features/account/domain/repositories/account_repository.dart';
import 'package:famxpense/features/auth/data/datasources/local/auth_local_datasource.dart';
import 'package:famxpense/features/debt_ledger/domain/usecases/compute_debt_usecase.dart';
import 'package:famxpense/features/expenses/data/datasources/local/expense_local_datasource.dart';
import 'package:famxpense/features/expenses/data/datasources/remote/expense_remote_datasource.dart';
import 'package:famxpense/features/expenses/data/repositories/expense_repository_impl.dart';
import 'package:famxpense/shared/domain/entities/expense/expense_entity.dart';
import 'package:famxpense/shared/domain/entities/expense/expense_participant_entity.dart';
import 'package:famxpense/shared/enums/expense_type.dart';
import 'package:famxpense/shared/enums/split_type.dart';
import 'package:famxpense/shared/enums/sync_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockExpenseLocal extends Mock implements ExpenseLocalDatasource {}

class _MockAuthLocal extends Mock implements AuthLocalDatasource {}

class _MockExpenseRemote extends Mock implements ExpenseRemoteDatasource {}

class _MockComputeDebt extends Mock implements ComputeDebtUsecase {}

class _MockAccountRepository extends Mock implements AccountRepository {}

void main() {
  late _MockExpenseLocal local;
  late _MockAuthLocal auth;
  late ExpenseRepositoryImpl repository;

  final now = DateTime(2026, 7, 31).toUtc();

  ExpenseEntity shared({
    double amount = 100,
    String paidByUserId = 'user-a',
    String ownerUserId = 'user-a',
    List<ExpenseParticipantEntity>? participants,
  }) {
    return ExpenseEntity(
      id: 'expense-1',
      title: 'Dinner',
      amount: amount,
      paidByUserId: paidByUserId,
      ownerUserId: ownerUserId,
      expenseType: ExpenseType.shared,
      splitType: SplitType.manual,
      participants:
          participants ??
          const [
            ExpenseParticipantEntity(userId: 'user-a', amount: 50),
            ExpenseParticipantEntity(userId: 'user-b', amount: 50),
          ],
      expenseDate: now,
      createdAt: now,
      updatedAt: now,
      syncStatus: SyncStatus.pending,
    );
  }

  setUp(() {
    local = _MockExpenseLocal();
    auth = _MockAuthLocal();
    when(() => auth.getUserId()).thenReturn('user-a');
    repository = ExpenseRepositoryImpl(
      localDatasource: local,
      authLocalDatasource: auth,
      remoteDatasource: _MockExpenseRemote(),
      computeDebtUsecase: _MockComputeDebt(),
      accountRepository: _MockAccountRepository(),
    );
  });

  test('rejects an expense owned by another authenticated user', () async {
    await expectLater(
      repository.addExpense(
        shared(paidByUserId: 'user-b', ownerUserId: 'user-b'),
      ),
      throwsStateError,
    );
    verifyZeroInteractions(local);
  });

  test('rejects shared participant totals that do not match exactly', () async {
    await expectLater(
      repository.addExpense(
        shared(
          participants: const [
            ExpenseParticipantEntity(userId: 'user-a', amount: 50),
            ExpenseParticipantEntity(userId: 'user-b', amount: 49.99),
          ],
        ),
      ),
      throwsArgumentError,
    );
    verifyZeroInteractions(local);
  });

  test('rejects duplicate participant IDs', () async {
    await expectLater(
      repository.addExpense(
        shared(
          participants: const [
            ExpenseParticipantEntity(userId: 'user-a', amount: 50),
            ExpenseParticipantEntity(userId: 'user-a', amount: 50),
          ],
        ),
      ),
      throwsArgumentError,
    );
    verifyZeroInteractions(local);
  });

  test('rejects money values with fractions smaller than one paise', () async {
    await expectLater(
      repository.addExpense(shared(amount: 100.001)),
      throwsArgumentError,
    );
    verifyZeroInteractions(local);
  });

  test('rejects a personal expense assigned to another participant', () async {
    final expense = shared(
      participants: const [
        ExpenseParticipantEntity(userId: 'user-b', amount: 100),
      ],
    ).copyWith(expenseType: ExpenseType.personal, splitType: SplitType.equal);

    await expectLater(repository.addExpense(expense), throwsArgumentError);
    verifyZeroInteractions(local);
  });
}
