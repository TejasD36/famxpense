import 'package:famxpense/features/account/data/datasources/account_local_datasource.dart';
import 'package:famxpense/features/account/data/datasources/remote/account_remote_datasource.dart';
import 'package:famxpense/features/account/data/repositories/account_repository_impl.dart';
import 'package:famxpense/shared/data/transformers/dtos/account/account_dto.dart';
import 'package:famxpense/shared/data/transformers/dtos/account/manual_deposit_dto.dart';
import 'package:famxpense/shared/domain/entities/account/account_entity.dart';
import 'package:famxpense/shared/enums/account_type.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockAccountLocal extends Mock implements AccountLocalDatasource {}

class _MockAccountRemote extends Mock implements AccountRemoteDatasource {}

void main() {
  late _MockAccountLocal local;
  late _MockAccountRemote remote;
  late AccountRepositoryImpl repository;

  final now = DateTime(2026, 7, 31).toUtc();
  final checking = AccountDto(
    id: 'checking',
    userId: 'user-a',
    accountName: 'Checking',
    accountType: AccountType.bank,
    currentBalance: 1000,
    createdAt: now,
    updatedAt: now,
  );
  final savings = AccountDto(
    id: 'savings',
    userId: 'user-a',
    accountName: 'Savings',
    accountType: AccountType.bank,
    currentBalance: 500,
    createdAt: now,
    updatedAt: now,
    isSavings: true,
  );

  setUpAll(() {
    registerFallbackValue(now);
    registerFallbackValue(checking);
    registerFallbackValue(<AccountDto>[]);
    registerFallbackValue(
      ManualDepositDto(
        id: '',
        userId: '',
        accountId: '',
        amount: 0,
        description: '',
        createdAt: now,
      ),
    );
    registerFallbackValue(
      AccountEntity(
        id: '',
        userId: '',
        accountName: '',
        accountType: AccountType.bank,
        currentBalance: 0,
        createdAt: now,
        updatedAt: now,
      ),
    );
  });

  setUp(() {
    local = _MockAccountLocal();
    remote = _MockAccountRemote();
    repository = AccountRepositoryImpl(
      localDatasource: local,
      remoteDatasource: remote,
    );
  });

  test('getAccounts never exposes deletion tombstones', () async {
    when(
      () => local.getAccounts(),
    ).thenAnswer((_) async => [checking, savings.copyWith(isDeleted: true)]);

    final result = await repository.getAccounts(userId: 'user-a');

    expect(result.map((account) => account.id), ['checking']);
  });

  test(
    'adjustBalance persists locally and uses a Firestore increment',
    () async {
      when(() => local.getAccounts()).thenAnswer((_) async => [checking]);
      when(() => local.saveAccount(any())).thenAnswer((_) async {});
      when(
        () => remote.adjustBalance(
          accountId: 'checking',
          delta: 250,
          mutationId: any(named: 'mutationId'),
          updatedAt: any(named: 'updatedAt'),
        ),
      ).thenAnswer((_) async {});

      final result = await repository.adjustBalance('checking', 250);

      expect(result.currentBalance, 1250);
      verify(
        () => local.saveAccount(
          any(
            that: predicate<AccountDto>(
              (account) =>
                  account.id == 'checking' && account.currentBalance == 1250,
            ),
          ),
        ),
      ).called(1);
      verify(
        () => remote.adjustBalance(
          accountId: 'checking',
          delta: 250,
          mutationId: any(named: 'mutationId'),
          updatedAt: any(named: 'updatedAt'),
        ),
      ).called(1);
    },
  );

  test(
    'manual edit records exact old and new balances in remote mutation',
    () async {
      var localState = checking;
      when(() => local.getAccounts()).thenAnswer((_) async => [localState]);
      when(() => local.saveAccount(any())).thenAnswer((invocation) async {
        localState = invocation.positionalArguments.single as AccountDto;
      });
      final entry = ManualDepositDto(
        id: 'edit-1',
        userId: 'user-a',
        accountId: 'checking',
        amount: -400,
        description: 'Manual balance edit',
        previousBalance: 1000,
        newBalance: 600,
        isBalanceEdit: true,
        createdAt: now,
      );
      when(
        () => remote.adjustBalance(
          accountId: 'checking',
          delta: -400,
          mutationId: 'manual-entry-edit-1',
          updatedAt: any(named: 'updatedAt'),
          accountEntry: entry,
        ),
      ).thenAnswer((_) async {});

      final result = await repository.recordManualBalanceChange(entry);

      expect(result.currentBalance, 600);
      verify(
        () => remote.adjustBalance(
          accountId: 'checking',
          delta: -400,
          mutationId: 'manual-entry-edit-1',
          updatedAt: any(named: 'updatedAt'),
          accountEntry: entry,
        ),
      ).called(1);
    },
  );

  test(
    'transferBalance saves both local balances together and batches remote deltas',
    () async {
      when(
        () => local.getAccounts(),
      ).thenAnswer((_) async => [checking, savings]);
      when(() => local.saveAccounts(any())).thenAnswer((_) async {});
      when(
        () => remote.transferBalance(
          fromAccountId: 'checking',
          toAccountId: 'savings',
          amount: 400,
          fromMutationId: any(named: 'fromMutationId'),
          toMutationId: any(named: 'toMutationId'),
          updatedAt: any(named: 'updatedAt'),
        ),
      ).thenAnswer((_) async {});

      final result = await repository.transferBalance(
        userId: 'user-a',
        fromAccountId: 'checking',
        toAccountId: 'savings',
        amount: 400,
      );

      expect(result.fromAccount.currentBalance, 600);
      expect(result.toAccount.currentBalance, 900);
      final saved =
          verify(() => local.saveAccounts(captureAny())).captured.single
              as List<AccountDto>;
      expect(saved.map((account) => account.currentBalance), [600, 900]);
      verify(
        () => remote.transferBalance(
          fromAccountId: 'checking',
          toAccountId: 'savings',
          amount: 400,
          fromMutationId: any(named: 'fromMutationId'),
          toMutationId: any(named: 'toMutationId'),
          updatedAt: any(named: 'updatedAt'),
        ),
      ).called(1);
    },
  );

  test('transferBalance rejects insufficient funds without writing', () async {
    when(
      () => local.getAccounts(),
    ).thenAnswer((_) async => [checking, savings]);

    expect(
      () => repository.transferBalance(
        userId: 'user-a',
        fromAccountId: 'checking',
        toAccountId: 'savings',
        amount: 1001,
      ),
      throwsStateError,
    );
    verifyNever(() => local.saveAccounts(any()));
  });

  test(
    'failed remote adjustment remains in the durable local journal',
    () async {
      var localState = checking;
      when(() => local.getAccounts()).thenAnswer((_) async => [localState]);
      when(() => local.saveAccount(any())).thenAnswer((invocation) async {
        localState = invocation.positionalArguments.single as AccountDto;
      });
      when(
        () => remote.adjustBalance(
          accountId: 'checking',
          delta: -100,
          mutationId: any(named: 'mutationId'),
          updatedAt: any(named: 'updatedAt'),
        ),
      ).thenThrow(Exception('Offline'));

      final result = await repository.adjustBalance('checking', -100);

      expect(result.currentBalance, 900);
      expect(result.pendingBalanceMutations, hasLength(1));
      expect(localState.currentBalance, 900);
      expect(localState.pendingBalanceMutations.values.single, -100);
    },
  );

  test(
    'replaying a completed mutation never changes the balance twice',
    () async {
      var localState = checking;
      when(() => local.getAccounts()).thenAnswer((_) async => [localState]);
      when(() => local.saveAccount(any())).thenAnswer((invocation) async {
        localState = invocation.positionalArguments.single as AccountDto;
      });
      when(
        () => remote.adjustBalance(
          accountId: 'checking',
          delta: 100,
          mutationId: 'income-1',
          updatedAt: any(named: 'updatedAt'),
        ),
      ).thenAnswer((_) async {});

      await repository.adjustBalance('checking', 100, mutationId: 'income-1');
      await repository.adjustBalance('checking', 100, mutationId: 'income-1');

      expect(localState.currentBalance, 1100);
      expect(localState.pendingBalanceMutations, isEmpty);
      expect(localState.appliedBalanceMutationIds, contains('income-1'));
      verify(
        () => remote.adjustBalance(
          accountId: 'checking',
          delta: 100,
          mutationId: 'income-1',
          updatedAt: any(named: 'updatedAt'),
        ),
      ).called(1);
    },
  );

  test(
    'failed remote deletion keeps a hidden tombstone for the next sync',
    () async {
      var localState = checking;
      when(
        () => local.getAccountsIncludingDeleted(),
      ).thenAnswer((_) async => [localState]);
      when(() => local.getAccounts()).thenAnswer((_) async => [localState]);
      when(() => local.saveAccount(any())).thenAnswer((invocation) async {
        localState = invocation.positionalArguments.single as AccountDto;
      });
      when(
        () => remote.deleteAccount('checking'),
      ).thenThrow(Exception('Offline'));

      await repository.deleteAccount('checking');

      expect(localState.isDeleted, true);
      expect(await repository.getAccounts(userId: 'user-a'), isEmpty);
      verifyNever(() => local.deleteAccount('checking'));
    },
  );

  test('account deletion is rejected while balance changes are pending', () {
    final pending = checking.copyWith(
      pendingBalanceMutations: const {'expense-1': -50},
    );
    when(
      () => local.getAccountsIncludingDeleted(),
    ).thenAnswer((_) async => [pending]);

    expect(() => repository.deleteAccount('checking'), throwsStateError);
    verifyNever(() => local.saveAccount(any()));
    verifyNever(() => remote.deleteAccount(any()));
  });
}
