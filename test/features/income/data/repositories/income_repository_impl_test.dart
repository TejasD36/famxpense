import 'package:famxpense/features/income/data/repositories/income_repository_impl.dart';
import 'package:famxpense/shared/data/transformers/dtos/income/income_dto.dart';
import 'package:famxpense/shared/data/transformers/mappers/income/income_mapper.dart';
import 'package:famxpense/shared/domain/entities/income/income_entity.dart';
import 'package:famxpense/shared/domain/entities/account/account_entity.dart';
import 'package:famxpense/shared/enums/income_source.dart';
import 'package:famxpense/shared/enums/account_type.dart';
import 'package:famxpense/shared/enums/sync_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../../mocks.dart';

void main() {
  late MockIncomeLocalDatasource mockLocal;
  late MockIncomeRemoteDatasource mockRemote;
  late MockAccountRepository mockAccountRepo;
  late MockAuthLocalDatasource mockAuth;
  late MockSavingsRepository mockSavingsRepo;
  late MockRefreshNotifier mockRefreshNotifier;
  late IncomeRepositoryImpl repository;

  final now = DateTime(2026, 7, 27, 12, 0, 0).toUtc();
  final incomeEntity = IncomeEntity(
    id: 'inc-1',
    userId: 'user-a',
    accountId: 'acct-1',
    amount: 5000.0,
    source: IncomeSource.salary,
    description: 'Salary',
    createdAt: now,
    updatedAt: now,
    syncStatus: SyncStatus.pending,
  );

  setUp(() {
    registerFallbacks();
    mockLocal = MockIncomeLocalDatasource();
    mockRemote = MockIncomeRemoteDatasource();
    mockAccountRepo = MockAccountRepository();
    mockAuth = MockAuthLocalDatasource();
    mockSavingsRepo = MockSavingsRepository();
    mockRefreshNotifier = MockRefreshNotifier();
    repository = IncomeRepositoryImpl(
      localDatasource: mockLocal,
      remoteDatasource: mockRemote,
      accountRepository: mockAccountRepo,
      authLocalDatasource: mockAuth,
      savingsRepository: mockSavingsRepo,
      refreshNotifier: mockRefreshNotifier,
    );
  });

  group('addIncome', () {
    test(
      'saves pending locally, credits account, then marks remote and local synced',
      () async {
        when(() => mockLocal.fetchAll()).thenAnswer((_) async => []);
        when(() => mockLocal.save(any())).thenAnswer((_) async {});
        when(() => mockRemote.createIncome(any())).thenAnswer((_) async {});
        when(() => mockAuth.getUserId()).thenReturn('user-a');
        final account = AccountEntity(
          id: 'acct-1',
          userId: 'user-a',
          accountName: 'Checking',
          accountType: AccountType.bank,
          currentBalance: 10000.0,
          createdAt: now,
          updatedAt: now,
        );
        when(
          () => mockAccountRepo.getAccounts(userId: 'user-a'),
        ).thenAnswer((_) async => [account]);
        when(
          () => mockAccountRepo.adjustBalance(
            'acct-1',
            5000,
            mutationId: 'income-credit-inc-1',
          ),
        ).thenAnswer((_) async => account.copyWith(currentBalance: 15000));

        await repository.addIncome(incomeEntity);

        verify(() => mockRemote.createIncome(any())).called(1);
        verify(() => mockLocal.save(any())).called(2);
        verify(
          () => mockAccountRepo.adjustBalance(
            'acct-1',
            5000.0,
            mutationId: 'income-credit-inc-1',
          ),
        ).called(1);
      },
    );

    test('saves locally and does not crash when remote fails', () async {
      when(() => mockLocal.fetchAll()).thenAnswer((_) async => []);
      when(() => mockLocal.save(any())).thenAnswer((_) async {});
      when(
        () => mockRemote.createIncome(any()),
      ).thenThrow(Exception('Network error'));
      when(() => mockAuth.getUserId()).thenReturn('user-a');
      final account = AccountEntity(
        id: 'acct-1',
        userId: 'user-a',
        accountName: 'Checking',
        accountType: AccountType.bank,
        currentBalance: 10000.0,
        createdAt: now,
        updatedAt: now,
      );
      when(
        () => mockAccountRepo.getAccounts(userId: 'user-a'),
      ).thenAnswer((_) async => [account]);
      when(
        () => mockAccountRepo.adjustBalance(
          'acct-1',
          5000,
          mutationId: 'income-credit-inc-1',
        ),
      ).thenAnswer((_) async => account.copyWith(currentBalance: 15000));

      await repository.addIncome(incomeEntity);

      verify(() => mockLocal.save(any())).called(1);
      verify(() => mockRemote.createIncome(any())).called(1);
      verify(
        () => mockAccountRepo.adjustBalance(
          'acct-1',
          5000.0,
          mutationId: 'income-credit-inc-1',
        ),
      ).called(1);
    });

    test('saves locally and credits balance even when remote fails', () async {
      when(() => mockLocal.fetchAll()).thenAnswer((_) async => []);
      when(() => mockLocal.save(any())).thenAnswer((_) async {});
      when(
        () => mockRemote.createIncome(any()),
      ).thenThrow(Exception('Offline'));
      when(() => mockAuth.getUserId()).thenReturn('user-a');
      final account = AccountEntity(
        id: 'acct-1',
        userId: 'user-a',
        accountName: 'Checking',
        accountType: AccountType.bank,
        currentBalance: 5000.0,
        createdAt: now,
        updatedAt: now,
      );
      when(
        () => mockAccountRepo.getAccounts(userId: 'user-a'),
      ).thenAnswer((_) async => [account]);
      when(
        () => mockAccountRepo.adjustBalance(
          'acct-1',
          5000,
          mutationId: 'income-credit-inc-1',
        ),
      ).thenAnswer((_) async => account.copyWith(currentBalance: 10000));

      await repository.addIncome(incomeEntity);

      verify(() => mockLocal.save(any())).called(1);
      verify(() => mockRemote.createIncome(any())).called(1);
      verify(
        () => mockAccountRepo.adjustBalance(
          'acct-1',
          5000.0,
          mutationId: 'income-credit-inc-1',
        ),
      ).called(1);
    });
  });

  group('getAllIncomes', () {
    test('returns entities from local datasource', () async {
      final dto = incomeEntity.toDto();
      when(() => mockLocal.fetchAll()).thenAnswer((_) async => [dto]);
      when(() => mockAuth.getUserId()).thenReturn('user-a');

      final result = await repository.getAllIncomes();

      expect(result.length, 1);
      expect(result.first.id, 'inc-1');
      expect(result.first.amount, 5000.0);
    });

    test('returns empty list on error', () async {
      when(() => mockLocal.fetchAll()).thenThrow(Exception('DB error'));
      when(() => mockAuth.getUserId()).thenReturn('user-a');

      final result = await repository.getAllIncomes();

      expect(result, isEmpty);
    });

    test('hides other users and pending deletion tombstones', () async {
      final deleted = incomeEntity
          .copyWith(id: 'deleted', isDeleted: true)
          .toDto();
      final other = incomeEntity
          .copyWith(id: 'other', userId: 'user-b')
          .toDto();
      when(
        () => mockLocal.fetchAll(),
      ).thenAnswer((_) async => [incomeEntity.toDto(), deleted, other]);
      when(() => mockAuth.getUserId()).thenReturn('user-a');

      final result = await repository.getAllIncomes();

      expect(result.map((income) => income.id), ['inc-1']);
    });
  });

  group('getIncomesByAccount', () {
    test('returns entities filtered by account', () async {
      final dto = incomeEntity.toDto();
      when(
        () => mockLocal.getByAccount('acct-1'),
      ).thenAnswer((_) async => [dto]);
      when(() => mockAuth.getUserId()).thenReturn('user-a');

      final result = await repository.getIncomesByAccount('acct-1');

      expect(result.length, 1);
      expect(result.first.accountId, 'acct-1');
    });
  });

  group('deleteIncome', () {
    test('deletes locally and remotely, reverses balance', () async {
      final dto = incomeEntity.toDto();
      when(() => mockLocal.fetchAll()).thenAnswer((_) async => [dto]);
      when(() => mockLocal.save(any())).thenAnswer((_) async {});
      when(() => mockLocal.deleteIncome('inc-1')).thenAnswer((_) async {});
      when(() => mockRemote.deleteIncome('inc-1')).thenAnswer((_) async {});
      when(() => mockAuth.getUserId()).thenReturn('user-a');
      final account = AccountEntity(
        id: 'acct-1',
        userId: 'user-a',
        accountName: 'Checking',
        accountType: AccountType.bank,
        currentBalance: 15000.0,
        createdAt: now,
        updatedAt: now,
      );
      when(
        () => mockAccountRepo.getAccounts(userId: 'user-a'),
      ).thenAnswer((_) async => [account]);
      when(
        () => mockAccountRepo.adjustBalance(
          'acct-1',
          -5000,
          mutationId: 'income-reversal-inc-1',
        ),
      ).thenAnswer((_) async => account.copyWith(currentBalance: 10000));

      await repository.deleteIncome('inc-1');

      verify(() => mockLocal.deleteIncome('inc-1')).called(1);
      verify(() => mockRemote.deleteIncome('inc-1')).called(1);
      verify(
        () => mockAccountRepo.adjustBalance(
          'acct-1',
          -5000.0,
          mutationId: 'income-reversal-inc-1',
        ),
      ).called(1);
      verify(
        () => mockLocal.save(
          any(that: predicate<IncomeDto>((income) => income.isDeleted)),
        ),
      ).called(1);
    });

    test('retains a tombstone when remote deletion fails', () async {
      final dto = incomeEntity.toDto();
      final account = AccountEntity(
        id: 'acct-1',
        userId: 'user-a',
        accountName: 'Checking',
        accountType: AccountType.bank,
        currentBalance: 15000,
        createdAt: now,
        updatedAt: now,
      );
      when(() => mockLocal.fetchAll()).thenAnswer((_) async => [dto]);
      when(() => mockLocal.save(any())).thenAnswer((_) async {});
      when(
        () => mockRemote.deleteIncome('inc-1'),
      ).thenThrow(Exception('Offline'));
      when(() => mockAuth.getUserId()).thenReturn('user-a');
      when(
        () => mockAccountRepo.getAccounts(userId: 'user-a'),
      ).thenAnswer((_) async => [account]);
      when(
        () => mockAccountRepo.adjustBalance(
          'acct-1',
          -5000,
          mutationId: 'income-reversal-inc-1',
        ),
      ).thenAnswer((_) async => account.copyWith(currentBalance: 10000));

      await repository.deleteIncome('inc-1');

      verifyNever(() => mockLocal.deleteIncome('inc-1'));
      verify(
        () => mockLocal.save(
          any(that: predicate<IncomeDto>((income) => income.isDeleted)),
        ),
      ).called(1);
    });
  });
}
