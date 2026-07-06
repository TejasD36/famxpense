import 'package:famxpense/core/services/refresh/refresh_notifier.dart';
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
  late ProcessSettlementUsecase usecase;

  setUpAll(() {
    registerFallbacks();
  });

  setUp(() {
    settlementRepository = MockSettlementRepository();
    debtLedgerRepository = MockDebtLedgerRepository();
    accountRepository = MockAccountRepository();

    sl.registerSingleton<RefreshNotifier>(RefreshNotifier());

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

      when(() => settlementRepository.getSettlementById(settlementId)).thenAnswer((_) async => settlement);
      when(() => settlementRepository.updateSettlementStatus(settlementId, SettlementStatus.confirmed))
          .thenAnswer((_) async {});
      when(() => debtLedgerRepository.updateDebt(any(), any(), any())).thenAnswer((_) async {});

      await usecase.confirm(settlementId: settlementId, toAccountId: 'deposit-account-1');

      verify(() => settlementRepository.updateSettlementStatus(settlementId, SettlementStatus.confirmed)).called(1);
      verify(() => debtLedgerRepository.updateDebt('user-recipient', 'user-payer', 100.0)).called(1);
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

      when(() => settlementRepository.getSettlementById(settlementId)).thenAnswer((_) async => settlement);
      when(() => settlementRepository.updateSettlementStatus(settlementId, SettlementStatus.confirmed))
          .thenAnswer((_) async {});
      when(() => debtLedgerRepository.updateDebt(any(), any(), any())).thenAnswer((_) async {});
      when(() => accountRepository.getAccounts(userId: any(named: 'userId'))).thenAnswer((_) async => [depositAccount]);
      when(() => accountRepository.updateBalance(any(), any())).thenAnswer((_) async {});

      await usecase.confirm(settlementId: settlementId, toAccountId: 'deposit-account-1');

      verify(() => accountRepository.updateBalance('deposit-account-1', 600.0)).called(1);
    });

    test('returns early when settlement is null', () async {
      when(() => settlementRepository.getSettlementById('nonexistent')).thenAnswer((_) async => null);

      await usecase.confirm(settlementId: 'nonexistent', toAccountId: null);

      verifyNever(() => settlementRepository.updateSettlementStatus(any(), any()));
      verifyNever(() => debtLedgerRepository.updateDebt(any(), any(), any()));
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

      when(() => settlementRepository.getSettlementById(settlementId)).thenAnswer((_) async => settlement);
      when(() => settlementRepository.updateSettlementStatus(settlementId, SettlementStatus.rejected))
          .thenAnswer((_) async {});

      await usecase.reject(settlementId: settlementId);

      verify(() => settlementRepository.updateSettlementStatus(settlementId, SettlementStatus.rejected)).called(1);
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

      when(() => settlementRepository.getSettlementById(settlementId)).thenAnswer((_) async => settlement);
      when(() => settlementRepository.updateSettlementStatus(settlementId, SettlementStatus.rejected))
          .thenAnswer((_) async {});
      when(() => accountRepository.getAccounts(userId: any(named: 'userId'))).thenAnswer((_) async => [account]);
      when(() => accountRepository.updateBalance(any(), any())).thenAnswer((_) async {});

      await usecase.reject(settlementId: settlementId);

      verify(() => accountRepository.updateBalance('account-1', 300.0)).called(1);
    });

    test('returns early when settlement is null', () async {
      when(() => settlementRepository.getSettlementById('nonexistent')).thenAnswer((_) async => null);

      await usecase.reject(settlementId: 'nonexistent');

      verifyNever(() => settlementRepository.updateSettlementStatus(any(), any()));
    });
  });
}
