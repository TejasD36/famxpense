import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:famxpense/core/services/sync/sync_service.dart';
import 'package:famxpense/features/account/data/datasources/account_local_datasource.dart';
import 'package:famxpense/features/account/data/datasources/manual_deposit_local_datasource.dart';
import 'package:famxpense/features/account/data/datasources/remote/account_remote_datasource.dart';
import 'package:famxpense/features/debt_ledger/data/datasources/debt_ledger_local_datasource.dart';
import 'package:famxpense/features/debt_ledger/data/datasources/remote/debt_ledger_remote_datasource.dart';
import 'package:famxpense/features/expenses/data/datasources/local/expense_local_datasource.dart';
import 'package:famxpense/features/expenses/data/datasources/remote/expense_remote_datasource.dart';
import 'package:famxpense/features/income/data/datasources/income_local_datasource.dart';
import 'package:famxpense/features/income/data/datasources/remote/income_remote_datasource.dart';
import 'package:famxpense/features/notification/data/datasources/notification_local_datasource.dart';
import 'package:famxpense/features/notification/data/datasources/remote/notification_remote_datasource.dart';
import 'package:famxpense/features/partners/data/datasources/remote/partnership_remote_datasource.dart';
import 'package:famxpense/features/savings/data/datasources/savings_local_datasource.dart';
import 'package:famxpense/features/savings/data/datasources/remote/monthly_saving_remote_datasource.dart';
import 'package:famxpense/features/savings/data/datasources/transfer_local_datasource.dart';
import 'package:famxpense/features/savings/data/datasources/remote/transfer_remote_datasource.dart';
import 'package:famxpense/features/savings/domain/repositories/savings_repository.dart';
import 'package:famxpense/features/settlement/data/datasources/settlement_local_datasource.dart';
import 'package:famxpense/features/settlement/data/datasources/remote/settlement_remote_datasource.dart';
import 'package:famxpense/shared/data/datasources/local/user_local_datasource.dart';
import 'package:famxpense/shared/data/datasources/remote/user_remote_datasource.dart';
import 'package:famxpense/shared/data/transformers/dtos/notification/notification_dto.dart';
import 'package:famxpense/shared/data/transformers/dtos/income/income_dto.dart';
import 'package:famxpense/shared/data/transformers/dtos/savings/monthly_saving_dto.dart';
import 'package:famxpense/shared/data/transformers/dtos/transfer/transfer_dto.dart';
import 'package:famxpense/shared/data/transformers/dtos/account/account_dto.dart';
import 'package:famxpense/shared/data/transformers/dtos/account/manual_deposit_dto.dart';
import 'package:famxpense/shared/domain/entities/account/account_entity.dart';
import 'package:famxpense/shared/enums/account_type.dart';
import 'package:famxpense/shared/enums/income_source.dart';
import 'package:famxpense/shared/enums/notification_type.dart';
import 'package:famxpense/shared/enums/sync_status.dart';

class MockExpenseLocalDatasource extends Mock
    implements ExpenseLocalDatasource {}

class MockExpenseRemoteDatasource extends Mock
    implements ExpenseRemoteDatasource {}

class MockAccountLocalDataSource extends Mock
    implements AccountLocalDatasource {}

class MockAccountRemoteDataSource extends Mock
    implements AccountRemoteDatasource {}

class MockManualDepositLocal extends Mock
    implements ManualDepositLocalDatasource {}

class MockDebtLedgerLocal extends Mock implements DebtLedgerLocalDatasource {}

class MockDebtLedgerRemote extends Mock implements DebtLedgerRemoteDatasource {}

class MockSettlementLocal extends Mock implements SettlementLocalDatasource {}

class MockSettlementRemote extends Mock implements SettlementRemoteDatasource {}

class MockUserLocal extends Mock implements UserLocalDatasource {}

class MockUserRemote extends Mock implements UserRemoteDatasource {}

class MockPartnershipRemote extends Mock
    implements PartnershipRemoteDatasource {}

class MockIncomeLocal extends Mock implements IncomeLocalDatasource {}

class MockIncomeRemote extends Mock implements IncomeRemoteDatasource {}

class MockNotificationLocal extends Mock
    implements NotificationLocalDatasource {}

class MockNotificationRemote extends Mock
    implements NotificationRemoteDatasource {}

class MockTransferLocal extends Mock implements TransferLocalDatasource {}

class MockTransferRemote extends Mock implements TransferRemoteDatasource {}

class MockSavingsLocalDatasource extends Mock
    implements SavingsLocalDatasource {}

class MockMonthlySavingRemoteDatasource extends Mock
    implements MonthlySavingRemoteDatasource {}

class MockSavingsRepository extends Mock implements SavingsRepository {}

void main() {
  setUpAll(() {
    registerFallbackValue(
      NotificationDto(
        id: 'fallback',
        userId: 'fallback',
        title: '',
        message: '',
        type: NotificationType.partnerRequest,
        createdAt: DateTime(2026, 1, 1),
      ),
    );
    registerFallbackValue(
      IncomeDto(
        id: 'fallback',
        userId: 'fallback',
        accountId: 'fallback',
        amount: 1,
        source: IncomeSource.other,
        description: '',
        createdAt: DateTime(2026),
        updatedAt: DateTime(2026),
      ),
    );
    registerFallbackValue(
      TransferDto(
        id: 'fallback',
        fromAccountId: 'from',
        toAccountId: 'to',
        fromUserId: 'fallback',
        toUserId: 'fallback',
        amount: 1,
        description: '',
        createdAt: DateTime(2026),
        updatedAt: DateTime(2026),
      ),
    );
    registerFallbackValue(
      MonthlySavingDto(
        id: 'fallback',
        accountId: 'fallback',
        year: 2026,
        month: 1,
        goalAmount: 0,
        savedAmount: 0,
        openingBalance: 0,
        closingBalance: 0,
        achievementPercent: 0,
      ),
    );
    registerFallbackValue(
      AccountDto(
        id: 'fallback',
        userId: 'fallback',
        accountName: '',
        accountType: AccountType.bank,
        currentBalance: 0,
        createdAt: DateTime(2026),
        updatedAt: DateTime(2026),
      ),
    );
    registerFallbackValue(
      ManualDepositDto(
        id: 'fallback',
        userId: 'fallback',
        accountId: 'fallback',
        amount: 0,
        description: '',
        createdAt: DateTime(2026),
      ),
    );
    registerFallbackValue(
      AccountEntity(
        id: 'fallback',
        userId: 'fallback',
        accountName: '',
        accountType: AccountType.bank,
        currentBalance: 0,
        createdAt: DateTime(2026),
        updatedAt: DateTime(2026),
      ),
    );
  });

  late SyncService syncService;
  late MockNotificationLocal notificationLocal;
  late MockNotificationRemote notificationRemote;
  late MockTransferLocal transferLocal;
  late MockTransferRemote transferRemote;
  late MockExpenseLocalDatasource expenseLocal;
  late MockExpenseRemoteDatasource expenseRemote;
  late MockAccountLocalDataSource accountLocal;
  late MockAccountRemoteDataSource accountRemote;
  late MockManualDepositLocal manualDepositLocal;
  late MockDebtLedgerLocal debtLedgerLocal;
  late MockDebtLedgerRemote debtLedgerRemote;
  late MockSettlementLocal settlementLocal;
  late MockSettlementRemote settlementRemote;
  late MockUserLocal userLocal;
  late MockUserRemote userRemote;
  late MockPartnershipRemote partnershipRemote;
  late MockIncomeLocal incomeLocal;
  late MockIncomeRemote incomeRemote;
  late MockSavingsLocalDatasource monthlySavingLocal;
  late MockMonthlySavingRemoteDatasource monthlySavingRemote;
  late MockSavingsRepository savingsRepository;

  setUp(() {
    expenseLocal = MockExpenseLocalDatasource();
    expenseRemote = MockExpenseRemoteDatasource();
    accountLocal = MockAccountLocalDataSource();
    accountRemote = MockAccountRemoteDataSource();
    manualDepositLocal = MockManualDepositLocal();
    debtLedgerLocal = MockDebtLedgerLocal();
    debtLedgerRemote = MockDebtLedgerRemote();
    settlementLocal = MockSettlementLocal();
    settlementRemote = MockSettlementRemote();
    userLocal = MockUserLocal();
    userRemote = MockUserRemote();
    partnershipRemote = MockPartnershipRemote();
    incomeLocal = MockIncomeLocal();
    incomeRemote = MockIncomeRemote();
    notificationLocal = MockNotificationLocal();
    notificationRemote = MockNotificationRemote();
    transferLocal = MockTransferLocal();
    transferRemote = MockTransferRemote();
    monthlySavingLocal = MockSavingsLocalDatasource();
    monthlySavingRemote = MockMonthlySavingRemoteDatasource();
    savingsRepository = MockSavingsRepository();

    syncService = SyncService(
      expenseLocal: expenseLocal,
      expenseRemote: expenseRemote,
      accountLocal: accountLocal,
      accountRemote: accountRemote,
      manualDepositLocal: manualDepositLocal,
      debtLedgerLocal: debtLedgerLocal,
      debtLedgerRemote: debtLedgerRemote,
      settlementLocal: settlementLocal,
      settlementRemote: settlementRemote,
      userLocal: userLocal,
      userRemote: userRemote,
      partnershipRemote: partnershipRemote,
      incomeLocal: incomeLocal,
      incomeRemote: incomeRemote,
      notificationLocal: notificationLocal,
      notificationRemote: notificationRemote,
      transferLocal: transferLocal,
      transferRemote: transferRemote,
      monthlySavingLocal: monthlySavingLocal,
      monthlySavingRemote: monthlySavingRemote,
      savingsRepository: savingsRepository,
    );
    when(() => manualDepositLocal.fetchAll()).thenAnswer((_) async => []);
    when(
      () => accountRemote.fetchAccountEntries(userId: any(named: 'userId')),
    ).thenAnswer((_) async => []);
    when(
      () => accountLocal.getAccountsIncludingDeleted(),
    ).thenAnswer((_) async => []);
  });

  group('syncAll', () {
    test('returns false when sync is already in progress', () async {
      when(
        () => expenseLocal.getPendingExpenses(
          ownerUserId: any(named: 'ownerUserId'),
        ),
      ).thenAnswer((_) async => []);
      when(
        () => expenseRemote.fetchExpenses(userId: any(named: 'userId')),
      ).thenAnswer((_) async => []);
      when(() => expenseLocal.saveExpenses(any())).thenAnswer((_) async {});
      when(
        () => expenseLocal.clearOldSyncedExpenses(
          ownerUserId: any(named: 'ownerUserId'),
        ),
      ).thenAnswer((_) async {});
      when(() => accountLocal.getAccounts()).thenAnswer((_) async => []);
      when(
        () => accountRemote.fetchAccounts(userId: any(named: 'userId')),
      ).thenAnswer((_) async => []);
      when(() => debtLedgerLocal.getLedgers()).thenAnswer((_) async => []);
      when(
        () => debtLedgerRemote.fetchLedgers(userId: any(named: 'userId')),
      ).thenAnswer((_) async => []);
      when(() => settlementLocal.getSettlements()).thenAnswer((_) async => []);
      when(
        () => settlementRemote.fetchSettlements(userId: any(named: 'userId')),
      ).thenAnswer((_) async => []);
      when(
        () => partnershipRemote.getPartnerships(userId: any(named: 'userId')),
      ).thenAnswer((_) async => []);
      when(() => incomeLocal.fetchAll()).thenAnswer((_) async => []);
      when(
        () => incomeRemote.fetchIncomes(userId: any(named: 'userId')),
      ).thenAnswer((_) async => []);
      when(
        () => notificationLocal.getNotifications(),
      ).thenAnswer((_) async => []);
      when(
        () =>
            notificationRemote.fetchNotifications(userId: any(named: 'userId')),
      ).thenAnswer((_) async => []);

      final first = syncService.syncAll(userId: 'user-a');
      final second = await syncService.syncAll(userId: 'user-a');
      await first;

      expect(second, false);
    });
  });

  group('syncIncomes', () {
    final now = DateTime(2026, 7, 31).toUtc();

    setUp(() {
      when(() => accountLocal.getAccounts()).thenAnswer(
        (_) async => [
          AccountDto(
            id: 'account-user-a',
            userId: 'user-a',
            accountName: 'Checking',
            accountType: AccountType.bank,
            currentBalance: 1000,
            createdAt: now,
            updatedAt: now,
            appliedBalanceMutationIds: const [
              'income-credit-own',
              'income-reversal-deleted',
              'income-credit-keep',
            ],
          ),
        ],
      );
    });

    IncomeDto income({
      required String id,
      required String userId,
      SyncStatus status = SyncStatus.synced,
      bool isDeleted = false,
      DateTime? updatedAt,
    }) {
      return IncomeDto(
        id: id,
        userId: userId,
        accountId: 'account-$userId',
        amount: 100,
        source: IncomeSource.salary,
        description: 'Income',
        createdAt: now,
        updatedAt: updatedAt ?? now,
        syncStatus: status,
        isDeleted: isDeleted,
      );
    }

    test('uploads only pending incomes owned by the current user', () async {
      final own = income(
        id: 'own',
        userId: 'user-a',
        status: SyncStatus.pending,
      );
      final other = income(
        id: 'other',
        userId: 'user-b',
        status: SyncStatus.pending,
      );
      when(() => incomeLocal.fetchAll()).thenAnswer((_) async => [own, other]);
      when(() => incomeLocal.save(any())).thenAnswer((_) async {});
      when(() => incomeRemote.createIncome(any())).thenAnswer((_) async {});
      when(
        () => incomeRemote.fetchIncomes(userId: 'user-a'),
      ).thenAnswer((_) async => []);

      final result = await syncService.syncIncomes(userId: 'user-a');

      expect(result, true);
      verify(
        () => incomeRemote.createIncome(
          any(
            that: predicate<IncomeDto>(
              (item) =>
                  item.id == 'own' && item.syncStatus == SyncStatus.synced,
            ),
          ),
        ),
      ).called(1);
      verifyNever(() => incomeRemote.createIncome(other));
    });

    test(
      'retries a tombstoned deletion and removes it locally only after success',
      () async {
        final deleted = income(
          id: 'deleted',
          userId: 'user-a',
          status: SyncStatus.pending,
          isDeleted: true,
        );
        when(() => incomeLocal.fetchAll()).thenAnswer((_) async => [deleted]);
        when(
          () => incomeRemote.deleteIncome('deleted'),
        ).thenAnswer((_) async {});
        when(
          () => incomeLocal.deleteIncome('deleted'),
        ).thenAnswer((_) async {});
        when(
          () => incomeRemote.fetchIncomes(userId: 'user-a'),
        ).thenAnswer((_) async => []);

        final result = await syncService.syncIncomes(userId: 'user-a');

        expect(result, true);
        verify(() => incomeRemote.deleteIncome('deleted')).called(1);
        verify(() => incomeLocal.deleteIncome('deleted')).called(1);
      },
    );

    test(
      'remote newer data replaces synced local data but never pending local data',
      () async {
        final localSynced = income(id: 'replace', userId: 'user-a');
        final localPending = income(
          id: 'keep',
          userId: 'user-a',
          status: SyncStatus.pending,
        );
        final remoteNewer = income(
          id: 'replace',
          userId: 'user-a',
          updatedAt: now.add(const Duration(minutes: 2)),
        );
        final remoteAgainstPending = income(
          id: 'keep',
          userId: 'user-a',
          updatedAt: now.add(const Duration(minutes: 2)),
        );
        when(
          () => incomeLocal.fetchAll(),
        ).thenAnswer((_) async => [localSynced, localPending]);
        when(() => incomeLocal.save(any())).thenAnswer((_) async {});
        when(() => incomeRemote.createIncome(any())).thenAnswer((_) async {});
        when(
          () => incomeRemote.fetchIncomes(userId: 'user-a'),
        ).thenAnswer((_) async => [remoteNewer, remoteAgainstPending]);

        await syncService.syncIncomes(userId: 'user-a');

        verify(
          () => incomeLocal.save(
            any(
              that: predicate<IncomeDto>(
                (item) =>
                    item.id == 'replace' &&
                    item.updatedAt == remoteNewer.updatedAt,
              ),
            ),
          ),
        ).called(1);
        verifyNever(() => incomeLocal.save(remoteAgainstPending));
      },
    );
  });

  group('syncAccounts', () {
    final now = DateTime(2026, 7, 31).toUtc();

    AccountEntity remoteAccount(double balance) => AccountEntity(
      id: 'account-a',
      userId: 'user-a',
      accountName: 'Checking',
      accountType: AccountType.bank,
      currentBalance: balance,
      createdAt: now,
      updatedAt: now,
    );

    test(
      'preserves both a remote concurrent change and an offline local change',
      () async {
        var localState = AccountDto(
          id: 'account-a',
          userId: 'user-a',
          accountName: 'Checking',
          accountType: AccountType.bank,
          currentBalance: 900,
          createdAt: now,
          updatedAt: now,
          pendingBalanceMutations: const {'offline-expense': -100},
        );
        when(
          () => accountLocal.getAccounts(),
        ).thenAnswer((_) async => [localState]);
        when(
          () => accountLocal.getAccountsIncludingDeleted(),
        ).thenAnswer((_) async => [localState]);
        when(() => accountLocal.saveAccount(any())).thenAnswer((
          invocation,
        ) async {
          localState = invocation.positionalArguments.single as AccountDto;
        });
        var fetchCount = 0;
        when(() => accountRemote.fetchAccounts(userId: 'user-a')).thenAnswer((
          _,
        ) async {
          fetchCount++;
          return [remoteAccount(fetchCount == 1 ? 1200 : 1100)];
        });
        when(
          () => accountRemote.adjustBalance(
            accountId: 'account-a',
            delta: -100,
            mutationId: 'offline-expense',
            updatedAt: any(named: 'updatedAt'),
          ),
        ).thenAnswer((_) async {});

        final result = await syncService.syncAccounts(userId: 'user-a');

        expect(result, true);
        expect(localState.currentBalance, 1100);
        expect(localState.pendingBalanceMutations, isEmpty);
        verify(
          () => accountRemote.adjustBalance(
            accountId: 'account-a',
            delta: -100,
            mutationId: 'offline-expense',
            updatedAt: any(named: 'updatedAt'),
          ),
        ).called(1);
      },
    );

    test(
      'keeps the local journal intact when Firestore is unavailable',
      () async {
        var localState = AccountDto(
          id: 'account-a',
          userId: 'user-a',
          accountName: 'Checking',
          accountType: AccountType.bank,
          currentBalance: 900,
          createdAt: now,
          updatedAt: now,
          pendingBalanceMutations: const {'offline-expense': -100},
        );
        when(
          () => accountLocal.getAccounts(),
        ).thenAnswer((_) async => [localState]);
        when(
          () => accountLocal.getAccountsIncludingDeleted(),
        ).thenAnswer((_) async => [localState]);
        when(() => accountLocal.saveAccount(any())).thenAnswer((
          invocation,
        ) async {
          localState = invocation.positionalArguments.single as AccountDto;
        });
        when(
          () => accountRemote.fetchAccounts(userId: 'user-a'),
        ).thenAnswer((_) async => [remoteAccount(1200)]);
        when(
          () => accountRemote.adjustBalance(
            accountId: 'account-a',
            delta: -100,
            mutationId: 'offline-expense',
            updatedAt: any(named: 'updatedAt'),
          ),
        ).thenThrow(Exception('Offline'));

        final result = await syncService.syncAccounts(userId: 'user-a');

        expect(result, false);
        expect(localState.currentBalance, 900);
        expect(localState.pendingBalanceMutations, {'offline-expense': -100});
      },
    );

    test('uploads a local-only account without losing it', () async {
      var localState = AccountDto(
        id: 'account-a',
        userId: 'user-a',
        accountName: 'Checking',
        accountType: AccountType.bank,
        currentBalance: 0,
        createdAt: now,
        updatedAt: now,
        hasPendingMetadataChanges: true,
      );
      when(
        () => accountLocal.getAccounts(),
      ).thenAnswer((_) async => [localState]);
      when(
        () => accountLocal.getAccountsIncludingDeleted(),
      ).thenAnswer((_) async => [localState]);
      when(() => accountLocal.saveAccount(any())).thenAnswer((
        invocation,
      ) async {
        localState = invocation.positionalArguments.single as AccountDto;
      });
      var fetchCount = 0;
      when(() => accountRemote.fetchAccounts(userId: 'user-a')).thenAnswer((
        _,
      ) async {
        fetchCount++;
        return fetchCount == 1 ? [] : [remoteAccount(0)];
      });
      when(() => accountRemote.createAccount(any())).thenAnswer((_) async {});

      final result = await syncService.syncAccounts(userId: 'user-a');

      expect(result, true);
      expect(localState.id, 'account-a');
      expect(localState.hasPendingMetadataChanges, false);
      verify(() => accountRemote.createAccount(any())).called(1);
      verifyNever(() => accountLocal.deleteAccount('account-a'));
    });

    test(
      'creates a missing account at its base balance before replaying mutations',
      () async {
        var localState = AccountDto(
          id: 'account-a',
          userId: 'user-a',
          accountName: 'Checking',
          accountType: AccountType.bank,
          currentBalance: 900,
          createdAt: now,
          updatedAt: now,
          pendingBalanceMutations: const {'offline-expense': -100},
        );
        when(
          () => accountLocal.getAccounts(),
        ).thenAnswer((_) async => [localState]);
        when(
          () => accountLocal.getAccountsIncludingDeleted(),
        ).thenAnswer((_) async => [localState]);
        when(() => accountLocal.saveAccount(any())).thenAnswer((
          invocation,
        ) async {
          localState = invocation.positionalArguments.single as AccountDto;
        });
        var fetchCount = 0;
        when(() => accountRemote.fetchAccounts(userId: 'user-a')).thenAnswer((
          _,
        ) async {
          fetchCount++;
          return fetchCount == 1 ? [] : [remoteAccount(900)];
        });
        when(() => accountRemote.createAccount(any())).thenAnswer((_) async {});
        when(
          () => accountRemote.adjustBalance(
            accountId: 'account-a',
            delta: -100,
            mutationId: 'offline-expense',
            updatedAt: any(named: 'updatedAt'),
          ),
        ).thenAnswer((_) async {});

        final result = await syncService.syncAccounts(userId: 'user-a');

        expect(result, true);
        final created =
            verify(
                  () => accountRemote.createAccount(captureAny()),
                ).captured.single
                as AccountEntity;
        expect(created.currentBalance, 1000);
        expect(created.pendingBalanceMutations, isEmpty);
        expect(localState.currentBalance, 900);
        expect(localState.pendingBalanceMutations, isEmpty);
      },
    );

    test('retries a queued account tombstone and removes it locally', () async {
      var localState = <AccountDto>[
        AccountDto(
          id: 'account-a',
          userId: 'user-a',
          accountName: 'Checking',
          accountType: AccountType.bank,
          currentBalance: 900,
          createdAt: now,
          updatedAt: now,
          isDeleted: true,
        ),
      ];
      when(
        () => accountLocal.getAccountsIncludingDeleted(),
      ).thenAnswer((_) async => localState);
      when(() => accountLocal.getAccounts()).thenAnswer((_) async => []);
      when(() => accountLocal.deleteAccount('account-a')).thenAnswer((_) async {
        localState = [];
      });
      when(
        () => accountRemote.fetchAccounts(userId: 'user-a'),
      ).thenAnswer((_) async => []);
      final result = await syncService.syncAccounts(userId: 'user-a');

      expect(result, true);
      expect(localState, isEmpty);
      verifyNever(() => accountRemote.deleteAccount('account-a'));
      verify(() => accountLocal.deleteAccount('account-a')).called(1);
    });

    test('manual entry retry never uses the generic mutation path', () async {
      const mutationId = 'manual-entry-edit-1';
      var localState = AccountDto(
        id: 'account-a',
        userId: 'user-a',
        accountName: 'Checking',
        accountType: AccountType.bank,
        currentBalance: 600,
        createdAt: now,
        updatedAt: now,
        pendingBalanceMutations: const {mutationId: -400},
      );
      final entry = ManualDepositDto(
        id: 'edit-1',
        userId: 'user-a',
        accountId: 'account-a',
        amount: -400,
        description: 'Manual balance edit',
        previousBalance: 1000,
        newBalance: 600,
        isBalanceEdit: true,
        createdAt: now,
        balanceApplied: true,
      );
      when(
        () => accountLocal.getAccounts(),
      ).thenAnswer((_) async => [localState]);
      when(
        () => accountLocal.getAccountsIncludingDeleted(),
      ).thenAnswer((_) async => [localState]);
      when(() => accountLocal.saveAccount(any())).thenAnswer((
        invocation,
      ) async {
        localState = invocation.positionalArguments.single as AccountDto;
      });
      when(
        () => manualDepositLocal.fetchAll(),
      ).thenAnswer((_) async => [entry]);
      when(() => manualDepositLocal.save(any())).thenAnswer((_) async {});
      when(
        () => accountRemote.fetchAccounts(userId: 'user-a'),
      ).thenAnswer((_) async => [remoteAccount(600)]);
      when(
        () => accountRemote.adjustBalance(
          accountId: 'account-a',
          delta: -400,
          mutationId: mutationId,
          updatedAt: now,
          accountEntry: entry,
        ),
      ).thenAnswer((_) async {});

      final result = await syncService.syncAccounts(userId: 'user-a');

      expect(result, true);
      expect(localState.pendingBalanceMutations, isEmpty);
      verify(
        () => accountRemote.adjustBalance(
          accountId: 'account-a',
          delta: -400,
          mutationId: mutationId,
          updatedAt: now,
          accountEntry: entry,
        ),
      ).called(1);
      verifyNever(
        () => accountRemote.adjustBalance(
          accountId: 'account-a',
          delta: -400,
          mutationId: mutationId,
          updatedAt: now,
        ),
      );
    });
  });

  group('syncTransfers', () {
    setUp(() {
      final now = DateTime(2026, 7, 31).toUtc();
      when(() => accountLocal.getAccounts()).thenAnswer(
        (_) async => [
          AccountDto(
            id: 'a',
            userId: 'user-a',
            accountName: 'From',
            accountType: AccountType.bank,
            currentBalance: 100,
            createdAt: now,
            updatedAt: now,
            appliedBalanceMutationIds: const ['transfer-own:debit'],
          ),
          AccountDto(
            id: 'b',
            userId: 'user-a',
            accountName: 'To',
            accountType: AccountType.bank,
            currentBalance: 10,
            createdAt: now,
            updatedAt: now,
            appliedBalanceMutationIds: const ['transfer-own:credit'],
          ),
        ],
      );
    });

    test('does not upload another user’s pending transfer', () async {
      final now = DateTime(2026, 7, 31).toUtc();
      final own = TransferDto(
        id: 'own',
        fromAccountId: 'a',
        toAccountId: 'b',
        fromUserId: 'user-a',
        toUserId: 'user-a',
        amount: 10,
        description: '',
        createdAt: now,
        updatedAt: now,
        syncStatus: SyncStatus.pending,
      );
      final other = own.copyWith(
        id: 'other',
        fromUserId: 'user-b',
        toUserId: 'user-b',
      );
      when(
        () => transferLocal.fetchAll(),
      ).thenAnswer((_) async => [own, other]);
      when(() => transferLocal.save(any())).thenAnswer((_) async {});
      when(() => transferRemote.createTransfer(any())).thenAnswer((_) async {});
      when(
        () => transferRemote.fetchTransfers(userId: 'user-a'),
      ).thenAnswer((_) async => []);

      final result = await syncService.syncTransfers(userId: 'user-a');

      expect(result, true);
      verify(
        () => transferRemote.createTransfer(
          any(that: predicate<TransferDto>((item) => item.id == 'own')),
        ),
      ).called(1);
      verifyNever(() => transferRemote.createTransfer(other));
    });
  });

  group('syncMonthlySavings', () {
    test(
      'backfills legacy ownership/timestamp and uploads without deleting history',
      () async {
        final now = DateTime(2026, 7, 31).toUtc();
        final account = AccountDto(
          id: 'savings',
          userId: 'user-a',
          accountName: 'Savings',
          accountType: AccountType.bank,
          currentBalance: 1000,
          createdAt: now,
          updatedAt: now,
          isSavings: true,
        );
        final legacy = MonthlySavingDto(
          id: 'legacy',
          accountId: 'savings',
          year: 2026,
          month: 6,
          goalAmount: 1000,
          savedAmount: 200,
          openingBalance: 800,
          closingBalance: 1000,
          achievementPercent: 20,
        );
        when(
          () => accountLocal.getAccounts(),
        ).thenAnswer((_) async => [account]);
        when(
          () => monthlySavingLocal.getAllSnapshots(),
        ).thenAnswer((_) async => [legacy]);
        when(
          () => monthlySavingLocal.saveSnapshot(any()),
        ).thenAnswer((_) async {});
        when(
          () => monthlySavingRemote.saveSnapshot(any()),
        ).thenAnswer((_) async {});
        when(
          () => monthlySavingRemote.fetchSnapshots(userId: 'user-a'),
        ).thenAnswer((_) async => []);

        final result = await syncService.syncMonthlySavings(userId: 'user-a');

        expect(result, true);
        verify(
          () => monthlySavingRemote.saveSnapshot(
            any(
              that: predicate<MonthlySavingDto>(
                (item) =>
                    item.id == 'legacy' &&
                    item.userId == 'user-a' &&
                    item.updatedAt != null,
              ),
            ),
          ),
        ).called(1);
      },
    );
  });

  group('syncNotifications', () {
    NotificationDto createNotification({
      required String id,
      required String userId,
      bool isOwn = true,
    }) {
      return NotificationDto(
        id: id,
        userId: userId,
        title: 'Notification $id',
        message: 'Message $id',
        type: NotificationType.partnerRequest,
        isRead: false,
        createdAt: DateTime(2026, 7, 1),
      );
    }

    test(
      'skips uploading notifications where userId != currentUserId',
      () async {
        final ownNotification = createNotification(id: 'n-1', userId: 'user-a');
        final otherNotification = createNotification(
          id: 'n-2',
          userId: 'user-b',
        );

        when(
          () => notificationLocal.getNotifications(),
        ).thenAnswer((_) async => [ownNotification, otherNotification]);
        when(
          () => notificationRemote.fetchNotifications(
            userId: any(named: 'userId'),
          ),
        ).thenAnswer((_) async => []);
        when(
          () => notificationRemote.uploadNotification(any()),
        ).thenAnswer((_) async {});
        when(
          () => notificationLocal.saveNotification(any()),
        ).thenAnswer((_) async {});

        await syncService.syncNotifications(userId: 'user-a');

        verify(
          () => notificationRemote.uploadNotification(ownNotification),
        ).called(1);
        verifyNever(
          () => notificationRemote.uploadNotification(otherNotification),
        );
      },
    );

    test('uploads own notifications and saves remote ones', () async {
      final localNotification = createNotification(id: 'n-1', userId: 'user-a');
      final remoteNotification = createNotification(
        id: 'n-2',
        userId: 'user-a',
      );

      when(
        () => notificationLocal.getNotifications(),
      ).thenAnswer((_) async => [localNotification]);
      when(
        () =>
            notificationRemote.fetchNotifications(userId: any(named: 'userId')),
      ).thenAnswer((_) async => [remoteNotification]);
      when(
        () => notificationRemote.uploadNotification(any()),
      ).thenAnswer((_) async {});
      when(
        () => notificationLocal.saveNotification(any()),
      ).thenAnswer((_) async {});

      await syncService.syncNotifications(userId: 'user-a');

      verify(
        () => notificationRemote.uploadNotification(localNotification),
      ).called(1);
      verify(
        () => notificationLocal.saveNotification(remoteNotification),
      ).called(1);
    });

    test('handles upload errors gracefully', () async {
      final notification = createNotification(id: 'n-1', userId: 'user-a');

      when(
        () => notificationLocal.getNotifications(),
      ).thenAnswer((_) async => [notification]);
      when(
        () =>
            notificationRemote.fetchNotifications(userId: any(named: 'userId')),
      ).thenAnswer((_) async => []);
      when(
        () => notificationRemote.uploadNotification(any()),
      ).thenThrow(Exception('Upload failed'));

      final result = await syncService.syncNotifications(userId: 'user-a');

      verify(
        () => notificationRemote.uploadNotification(notification),
      ).called(1);
      expect(result, false);
    });
  });
}
