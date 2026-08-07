import 'package:famxpense/core/services/sync/sync_service.dart';
import 'package:famxpense/core/services/refresh/refresh_notifier.dart';
import 'package:famxpense/features/auth/data/datasources/local/auth_local_datasource.dart';
import 'package:famxpense/features/settlement/data/datasources/remote/settlement_remote_datasource.dart';
import 'package:famxpense/features/settlement/domain/usecases/process_settlement_usecase.dart';
import 'package:famxpense/shared/domain/entities/account/account_entity.dart';
import 'package:famxpense/shared/domain/entities/settlement/settlement_entity.dart';
import 'package:famxpense/shared/enums/account_type.dart';
import 'package:famxpense/shared/enums/settlement_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';

final sl = GetIt.instance;

void main() {
  late MockSettlementRepository settlementRepository;
  late MockDebtLedgerRepository debtLedgerRepository;
  late MockAccountRepository accountRepository;
  late MockAuthLocalDatasource authLocalDatasource;
  late MockSettlementRemoteDatasource settlementRemoteDatasource;
  late ProcessSettlementUsecase usecase;

  setUpAll(() {
    registerFallbacks();
  });

  setUp(() {
    settlementRepository = MockSettlementRepository();
    debtLedgerRepository = MockDebtLedgerRepository();
    accountRepository = MockAccountRepository();
    authLocalDatasource = MockAuthLocalDatasource();
    settlementRemoteDatasource = MockSettlementRemoteDatasource();

    when(() => authLocalDatasource.getUserId()).thenReturn('user-payer');
    when(
      () => settlementRemoteDatasource.fetchSettlementById(any()),
    ).thenAnswer((_) async => null);

    sl.registerSingleton<RefreshNotifier>(RefreshNotifier());
    sl.registerSingleton<SyncService>(MockSyncService());
    sl.registerSingleton<AuthLocalDatasource>(authLocalDatasource);
    sl.registerSingleton<SettlementRemoteDatasource>(
      settlementRemoteDatasource,
    );

    usecase = ProcessSettlementUsecase(
      settlementRepository: settlementRepository,
      debtLedgerRepository: debtLedgerRepository,
      accountRepository: accountRepository,
    );
  });

  tearDown(() {
    sl.reset();
  });

  group('confirm', () {
    test('updates settlement status and debt ledger', () async {
      const settlementId = 'settlement-1';
      final settlement = SettlementEntity(
        id: settlementId,
        fromUserId: 'user-payer',
        toUserId: 'user-recipient',
        amount: 100.0,
        status: SettlementStatus.pending,
        createdAt: DateTime(2026, 7, 1),
        accountId: 'account-1',
      );

      when(
        () => settlementRepository.getSettlementById(settlementId),
      ).thenAnswer((_) async => settlement);
      when(
        () => settlementRepository.updateSettlementStatus(
          settlementId,
          SettlementStatus.confirmed,
        ),
      ).thenAnswer((_) async {});
      when(
        () => debtLedgerRepository.updateDebt(
          any(),
          any(),
          any(),
          mutationId: any(named: 'mutationId'),
        ),
      ).thenAnswer((_) async {});
      when(
        () => accountRepository.getAccounts(userId: any(named: 'userId')),
      ).thenAnswer((_) async => []);
      when(
        () => sl<SyncService>().syncAll(userId: any(named: 'userId')),
      ).thenAnswer((_) async => true);

      await usecase.confirm(
        settlementId: settlementId,
        toAccountId: 'deposit-account-1',
      );

      verify(
        () => settlementRepository.updateSettlementStatus(
          settlementId,
          SettlementStatus.confirmed,
        ),
      ).called(1);
      verify(
        () => debtLedgerRepository.updateDebt(
          'user-recipient',
          'user-payer',
          100.0,
          mutationId: 'settlement-confirm-debt-settlement-1',
        ),
      ).called(1);
    });

    test('deposits to specified account', () async {
      const settlementId = 'settlement-1';
      final settlement = SettlementEntity(
        id: settlementId,
        fromUserId: 'user-payer',
        toUserId: 'user-recipient',
        amount: 100.0,
        status: SettlementStatus.pending,
        createdAt: DateTime(2026, 7, 1),
        accountId: 'account-1',
      );

      final depositAccount = AccountEntity(
        id: 'deposit-account-1',
        userId: 'user-recipient',
        accountName: 'Wallet',
        accountType: AccountType.wallet,
        currentBalance: 500.0,
        createdAt: DateTime(2026, 7, 1),
        updatedAt: DateTime(2026, 7, 1),
      );

      when(
        () => settlementRepository.getSettlementById(settlementId),
      ).thenAnswer((_) async => settlement);
      when(
        () => settlementRepository.updateSettlementStatus(
          settlementId,
          SettlementStatus.confirmed,
        ),
      ).thenAnswer((_) async {});
      when(
        () => debtLedgerRepository.updateDebt(
          any(),
          any(),
          any(),
          mutationId: any(named: 'mutationId'),
        ),
      ).thenAnswer((_) async {});
      when(
        () => accountRepository.getAccounts(userId: any(named: 'userId')),
      ).thenAnswer((_) async => [depositAccount]);
      when(
        () => accountRepository.adjustBalance(
          'deposit-account-1',
          100,
          mutationId: 'settlement-receipt-settlement-1',
        ),
      ).thenAnswer((_) async => depositAccount.copyWith(currentBalance: 600));
      when(
        () => sl<SyncService>().syncAll(userId: any(named: 'userId')),
      ).thenAnswer((_) async => true);

      await usecase.confirm(
        settlementId: settlementId,
        toAccountId: 'deposit-account-1',
      );

      verify(
        () => accountRepository.adjustBalance(
          'deposit-account-1',
          100.0,
          mutationId: 'settlement-receipt-settlement-1',
        ),
      ).called(1);
    });

    test('returns early when settlement is null', () async {
      when(
        () => settlementRepository.getSettlementById('nonexistent'),
      ).thenAnswer((_) async => null);

      await usecase.confirm(settlementId: 'nonexistent', toAccountId: null);

      verifyNever(
        () => settlementRepository.updateSettlementStatus(any(), any()),
      );
      verifyNever(
        () => debtLedgerRepository.updateDebt(
          any(),
          any(),
          any(),
          mutationId: any(named: 'mutationId'),
        ),
      );
    });
  });

  group('reject', () {
    test('updates settlement status to rejected', () async {
      const settlementId = 'settlement-1';
      final settlement = SettlementEntity(
        id: settlementId,
        fromUserId: 'user-payer',
        toUserId: 'user-recipient',
        amount: 100.0,
        status: SettlementStatus.pending,
        createdAt: DateTime(2026, 7, 1),
        accountId: 'account-1',
      );

      when(
        () => settlementRepository.getSettlementById(settlementId),
      ).thenAnswer((_) async => settlement);
      when(
        () => settlementRepository.updateSettlementStatus(
          settlementId,
          SettlementStatus.rejected,
        ),
      ).thenAnswer((_) async {});
      when(
        () => accountRepository.getAccounts(userId: any(named: 'userId')),
      ).thenAnswer((_) async => []);

      await usecase.reject(settlementId: settlementId);

      verify(
        () => settlementRepository.updateSettlementStatus(
          settlementId,
          SettlementStatus.rejected,
        ),
      ).called(1);
    });

    test('refunds payer account when accountId exists', () async {
      const settlementId = 'settlement-1';
      final settlement = SettlementEntity(
        id: settlementId,
        fromUserId: 'user-payer',
        toUserId: 'user-recipient',
        amount: 100.0,
        status: SettlementStatus.pending,
        createdAt: DateTime(2026, 7, 1),
        accountId: 'account-1',
      );

      final account = AccountEntity(
        id: 'account-1',
        userId: 'user-payer',
        accountName: 'Wallet',
        accountType: AccountType.wallet,
        currentBalance: 200.0,
        createdAt: DateTime(2026, 7, 1),
        updatedAt: DateTime(2026, 7, 1),
      );

      when(
        () => settlementRepository.getSettlementById(settlementId),
      ).thenAnswer((_) async => settlement);
      when(
        () => settlementRepository.updateSettlementStatus(
          settlementId,
          SettlementStatus.rejected,
        ),
      ).thenAnswer((_) async {});
      when(
        () => accountRepository.getAccounts(userId: any(named: 'userId')),
      ).thenAnswer((_) async => [account]);
      when(
        () => accountRepository.adjustBalance(
          'account-1',
          100,
          mutationId: 'settlement-rejection-refund-settlement-1',
        ),
      ).thenAnswer((_) async => account.copyWith(currentBalance: 300));

      await usecase.reject(settlementId: settlementId);

      verify(
        () => accountRepository.adjustBalance(
          'account-1',
          100.0,
          mutationId: 'settlement-rejection-refund-settlement-1',
        ),
      ).called(1);
    });

    test('does not refund payer account when current user is the recipient',
        () async {
      const settlementId = 'settlement-1';
      final settlement = SettlementEntity(
        id: settlementId,
        fromUserId: 'user-payer',
        toUserId: 'user-recipient',
        amount: 100.0,
        status: SettlementStatus.pending,
        createdAt: DateTime(2026, 7, 1),
        accountId: 'account-1',
      );

      final account = AccountEntity(
        id: 'account-1',
        userId: 'user-payer',
        accountName: 'Wallet',
        accountType: AccountType.wallet,
        currentBalance: 200.0,
        createdAt: DateTime(2026, 7, 1),
        updatedAt: DateTime(2026, 7, 1),
      );

      when(() => authLocalDatasource.getUserId()).thenReturn('user-recipient');
      when(
        () => settlementRepository.getSettlementById(settlementId),
      ).thenAnswer((_) async => settlement);
      when(
        () => settlementRepository.updateSettlementStatus(
          settlementId,
          SettlementStatus.rejected,
        ),
      ).thenAnswer((_) async {});
      when(
        () => accountRepository.getAccounts(userId: any(named: 'userId')),
      ).thenAnswer((_) async => [account]);

      await usecase.reject(settlementId: settlementId);

      verifyNever(
        () => accountRepository.adjustBalance(
          any(),
          any(),
          mutationId: any(named: 'mutationId'),
        ),
      );
      verify(
        () => settlementRepository.updateSettlementStatus(
          settlementId,
          SettlementStatus.rejected,
        ),
      ).called(1);
    });

    test('returns early when settlement was already resolved remotely',
        () async {
      const settlementId = 'settlement-1';
      final settlement = SettlementEntity(
        id: settlementId,
        fromUserId: 'user-payer',
        toUserId: 'user-recipient',
        amount: 100.0,
        status: SettlementStatus.pending,
        createdAt: DateTime(2026, 7, 1),
        accountId: 'account-1',
      );

      when(
        () => settlementRepository.getSettlementById(settlementId),
      ).thenAnswer((_) async => settlement);
      when(
        () => settlementRemoteDatasource.fetchSettlementById(settlementId),
      ).thenAnswer(
        (_) async => settlement.copyWith(status: SettlementStatus.confirmed),
      );

      await usecase.reject(settlementId: settlementId);

      verifyNever(
        () => settlementRepository.updateSettlementStatus(any(), any()),
      );
      verifyNever(
        () => accountRepository.adjustBalance(
          any(),
          any(),
          mutationId: any(named: 'mutationId'),
        ),
      );
    });

    test('returns early when settlement is null', () async {
      when(
        () => settlementRepository.getSettlementById('nonexistent'),
      ).thenAnswer((_) async => null);

      await usecase.reject(settlementId: 'nonexistent');

      verifyNever(
        () => settlementRepository.updateSettlementStatus(any(), any()),
      );
    });
  });
}
