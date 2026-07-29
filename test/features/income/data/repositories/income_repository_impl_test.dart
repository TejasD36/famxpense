import 'package:famxpense/features/income/data/datasources/income_local_datasource.dart';
import 'package:famxpense/features/income/data/datasources/remote/income_remote_datasource.dart';
import 'package:famxpense/features/income/data/repositories/income_repository_impl.dart';
import 'package:famxpense/features/account/domain/repositories/account_repository.dart';
import 'package:famxpense/features/auth/data/datasources/local/auth_local_datasource.dart';
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
    mockRefreshNotifier = MockRefreshNotifier();
    repository = IncomeRepositoryImpl(
      localDatasource: mockLocal,
      remoteDatasource: mockRemote,
      accountRepository: mockAccountRepo,
      authLocalDatasource: mockAuth,
      refreshNotifier: mockRefreshNotifier,
    );
  });

  group('addIncome', () {
    test('saves to remote first, then locally, then credits account balance', () async {
      when(() => mockLocal.save(any())).thenAnswer((_) async {});
      when(() => mockRemote.createIncome(any())).thenAnswer((_) async {});
      when(() => mockAuth.getUserId()).thenReturn('user-a');
      when(() => mockAccountRepo.getAccounts(userId: any(named: 'userId'))).thenAnswer((_) async => [
        AccountEntity(
          id: 'acct-1',
          userId: 'user-a',
          accountName: 'Checking',
          accountType: AccountType.bank,
          currentBalance: 10000.0,
          createdAt: now,
          updatedAt: now,
        ),
      ]);
      when(() => mockAccountRepo.updateBalance(any(), any())).thenAnswer((_) async {});

      await repository.addIncome(incomeEntity);

      verify(() => mockRemote.createIncome(any())).called(1);
      verify(() => mockLocal.save(any())).called(1);
      verify(() => mockAccountRepo.updateBalance('acct-1', 15000.0)).called(1);
    });

    test('saves locally and does not crash when remote fails', () async {
      when(() => mockLocal.save(any())).thenAnswer((_) async {});
      when(() => mockRemote.createIncome(any())).thenThrow(Exception('Network error'));
      when(() => mockAuth.getUserId()).thenReturn('user-a');
      when(() => mockAccountRepo.getAccounts(userId: any(named: 'userId'))).thenAnswer((_) async => [
        AccountEntity(
          id: 'acct-1',
          userId: 'user-a',
          accountName: 'Checking',
          accountType: AccountType.bank,
          currentBalance: 10000.0,
          createdAt: now,
          updatedAt: now,
        ),
      ]);
      when(() => mockAccountRepo.updateBalance(any(), any())).thenAnswer((_) async {});

      await repository.addIncome(incomeEntity);

      verify(() => mockLocal.save(any())).called(1);
      verify(() => mockRemote.createIncome(any())).called(1);
      verify(() => mockAccountRepo.updateBalance('acct-1', 15000.0)).called(1);
    });

    test('saves locally and credits balance even when remote fails', () async {
      when(() => mockLocal.save(any())).thenAnswer((_) async {});
      when(() => mockRemote.createIncome(any())).thenThrow(Exception('Offline'));
      when(() => mockAuth.getUserId()).thenReturn('user-a');
      when(() => mockAccountRepo.getAccounts(userId: any(named: 'userId'))).thenAnswer((_) async => [
        AccountEntity(
          id: 'acct-1',
          userId: 'user-a',
          accountName: 'Checking',
          accountType: AccountType.bank,
          currentBalance: 5000.0,
          createdAt: now,
          updatedAt: now,
        ),
      ]);
      when(() => mockAccountRepo.updateBalance(any(), any())).thenAnswer((_) async {});

      await repository.addIncome(incomeEntity);

      verify(() => mockLocal.save(any())).called(1);
      verify(() => mockRemote.createIncome(any())).called(1);
      verify(() => mockAccountRepo.updateBalance('acct-1', 10000.0)).called(1);
    });
  });

  group('getAllIncomes', () {
    test('returns entities from local datasource', () async {
      final dto = incomeEntity.toDto();
      when(() => mockLocal.fetchAll()).thenAnswer((_) async => [dto]);

      final result = await repository.getAllIncomes();

      expect(result.length, 1);
      expect(result.first.id, 'inc-1');
      expect(result.first.amount, 5000.0);
    });

    test('returns empty list on error', () async {
      when(() => mockLocal.fetchAll()).thenThrow(Exception('DB error'));

      final result = await repository.getAllIncomes();

      expect(result, isEmpty);
    });
  });

  group('getIncomesByAccount', () {
    test('returns entities filtered by account', () async {
      final dto = incomeEntity.toDto();
      when(() => mockLocal.getByAccount('acct-1')).thenAnswer((_) async => [dto]);

      final result = await repository.getIncomesByAccount('acct-1');

      expect(result.length, 1);
      expect(result.first.accountId, 'acct-1');
    });
  });

  group('deleteIncome', () {
    test('deletes locally and remotely, reverses balance', () async {
      final dto = incomeEntity.toDto();
      when(() => mockLocal.fetchAll()).thenAnswer((_) async => [dto]);
      when(() => mockLocal.deleteIncome('inc-1')).thenAnswer((_) async {});
      when(() => mockRemote.deleteIncome('inc-1')).thenAnswer((_) async {});
      when(() => mockAuth.getUserId()).thenReturn('user-a');
      when(() => mockAccountRepo.getAccounts(userId: any(named: 'userId'))).thenAnswer((_) async => [
        AccountEntity(
          id: 'acct-1',
          userId: 'user-a',
          accountName: 'Checking',
          accountType: AccountType.bank,
          currentBalance: 15000.0,
          createdAt: now,
          updatedAt: now,
        ),
      ]);
      when(() => mockAccountRepo.updateBalance(any(), any())).thenAnswer((_) async {});

      await repository.deleteIncome('inc-1');

      verify(() => mockLocal.deleteIncome('inc-1')).called(1);
      verify(() => mockRemote.deleteIncome('inc-1')).called(1);
      verify(() => mockAccountRepo.updateBalance('acct-1', 10000.0)).called(1);
    });
  });
}
