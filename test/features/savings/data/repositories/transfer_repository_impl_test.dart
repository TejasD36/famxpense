import 'package:famxpense/features/savings/data/repositories/transfer_repository_impl.dart';
import 'package:famxpense/shared/data/transformers/dtos/transfer/transfer_dto.dart';
import 'package:famxpense/shared/domain/entities/account/account_entity.dart';
import 'package:famxpense/shared/domain/entities/savings/monthly_saving_entity.dart';
import 'package:famxpense/shared/enums/account_type.dart';
import 'package:famxpense/shared/enums/sync_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';

void main() {
  late MockTransferLocalDatasource local;
  late MockTransferRemoteDatasource remote;
  late MockAccountRepository accountRepository;
  late MockSavingsRepository savingsRepository;
  late MockRefreshNotifier refreshNotifier;
  late TransferRepositoryImpl repository;

  final now = DateTime(2026, 7, 31).toUtc();
  final transfer = TransferDto(
    id: 'transfer-1',
    fromAccountId: 'checking',
    toAccountId: 'savings',
    fromUserId: 'user-a',
    toUserId: 'user-a',
    amount: 250,
    description: 'Save',
    createdAt: now,
    updatedAt: now,
  );
  final checking = AccountEntity(
    id: 'checking',
    userId: 'user-a',
    accountName: 'Checking',
    accountType: AccountType.bank,
    currentBalance: 750,
    createdAt: now,
    updatedAt: now,
  );
  final savings = AccountEntity(
    id: 'savings',
    userId: 'user-a',
    accountName: 'Savings',
    accountType: AccountType.bank,
    currentBalance: 1250,
    createdAt: now,
    updatedAt: now,
    isSavings: true,
    monthlySavingsGoal: 5000,
  );

  setUpAll(registerFallbacks);

  setUp(() {
    local = MockTransferLocalDatasource();
    remote = MockTransferRemoteDatasource();
    accountRepository = MockAccountRepository();
    savingsRepository = MockSavingsRepository();
    refreshNotifier = MockRefreshNotifier();
    repository = TransferRepositoryImpl(
      local: local,
      remote: remote,
      accountRepository: accountRepository,
      savingsRepository: savingsRepository,
      refreshNotifier: refreshNotifier,
    );
  });

  test(
    'persists pending, moves both balances, updates savings, and marks synced',
    () async {
      when(() => local.fetchAll()).thenAnswer((_) async => []);
      when(() => local.save(any())).thenAnswer((_) async {});
      when(
        () => accountRepository.transferBalance(
          userId: 'user-a',
          fromAccountId: 'checking',
          toAccountId: 'savings',
          amount: 250,
          mutationId: 'transfer-transfer-1',
        ),
      ).thenAnswer((_) async => (fromAccount: checking, toAccount: savings));
      when(
        () => savingsRepository.computeCurrentMonth('savings', 1250, 5000),
      ).thenAnswer(
        (_) async => MonthlySavingEntity(
          id: 'snapshot',
          accountId: 'savings',
          year: 2026,
          month: 7,
          goalAmount: 5000,
          savedAmount: 250,
          openingBalance: 1000,
          closingBalance: 1250,
          achievementPercent: 5,
          userId: 'user-a',
        ),
      );
      when(() => remote.createTransfer(any())).thenAnswer((_) async {});

      await repository.saveTransfer(transfer);

      verify(
        () => local.save(
          any(
            that: predicate<TransferDto>(
              (item) =>
                  item.id == 'transfer-1' &&
                  item.syncStatus == SyncStatus.pending,
            ),
          ),
        ),
      ).called(1);
      verify(
        () => local.save(
          any(
            that: predicate<TransferDto>(
              (item) =>
                  item.id == 'transfer-1' &&
                  item.syncStatus == SyncStatus.synced,
            ),
          ),
        ),
      ).called(1);
      verify(
        () => savingsRepository.computeCurrentMonth('savings', 1250, 5000),
      ).called(1);
    },
  );

  test('keeps the local transfer pending when Firestore fails', () async {
    when(() => local.fetchAll()).thenAnswer((_) async => []);
    when(() => local.save(any())).thenAnswer((_) async {});
    when(
      () => accountRepository.transferBalance(
        userId: 'user-a',
        fromAccountId: 'checking',
        toAccountId: 'savings',
        amount: 250,
        mutationId: 'transfer-transfer-1',
      ),
    ).thenAnswer(
      (_) async =>
          (fromAccount: checking, toAccount: checking.copyWith(id: 'savings')),
    );
    when(() => remote.createTransfer(any())).thenThrow(Exception('Offline'));

    await repository.saveTransfer(transfer);

    verify(() => local.save(any())).called(1);
  });

  test('rejects a transfer to the same account before writing', () async {
    final invalid = transfer.copyWith(toAccountId: 'checking');

    expect(() => repository.saveTransfer(invalid), throwsArgumentError);
    verifyNever(() => local.save(any()));
  });
}
