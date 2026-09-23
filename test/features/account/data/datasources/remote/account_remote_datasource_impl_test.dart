import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:famxpense/features/account/data/datasources/remote/account_remote_datasource_impl.dart';
import 'package:famxpense/shared/data/transformers/dtos/account/manual_deposit_dto.dart';
import 'package:famxpense/shared/domain/entities/account/account_entity.dart';
import 'package:famxpense/shared/enums/account_type.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FakeFirebaseFirestore firestore;
  late AccountRemoteDatasourceImpl datasource;
  final now = DateTime(2026, 7, 31).toUtc();

  AccountEntity account(String id, double balance) => AccountEntity(
    id: id,
    userId: 'user-a',
    accountName: id,
    accountType: AccountType.bank,
    currentBalance: balance,
    createdAt: now,
    updatedAt: now,
  );

  setUp(() {
    firestore = FakeFirebaseFirestore();
    datasource = AccountRemoteDatasourceImpl(firestore: firestore);
  });

  test(
    'createAccount writes a new account without a prerequisite read',
    () async {
      await datasource.createAccount(account('checking', 1000));

      expect(
        (await firestore.collection('accounts').doc('checking').get()).exists,
        true,
      );
    },
  );

  test('adjustBalance uses an atomic increment', () async {
    await datasource.createAccount(account('checking', 1000));

    await datasource.adjustBalance(
      accountId: 'checking',
      delta: 250,
      mutationId: 'income-1',
      updatedAt: now.add(const Duration(minutes: 1)),
    );
    await datasource.adjustBalance(
      accountId: 'checking',
      delta: 250,
      mutationId: 'income-1',
      updatedAt: now.add(const Duration(minutes: 2)),
    );

    final data = (await firestore.collection('accounts').doc('checking').get())
        .data()!;
    expect(data['currentBalance'], 1250);
    expect(
      (await firestore
              .collection('account_balance_mutations')
              .doc('income-1')
              .get())
          .exists,
      true,
    );
  });

  test('manual balance entry and mutation are idempotent and atomic', () async {
    await datasource.createAccount(account('checking', 1000));
    final entry = ManualDepositDto(
      id: 'edit-1',
      userId: 'user-a',
      accountId: 'checking',
      amount: 250,
      description: 'Manual balance edit',
      previousBalance: 1000,
      newBalance: 1250,
      isBalanceEdit: true,
      createdAt: now,
      balanceApplied: true,
    );

    for (var attempt = 0; attempt < 2; attempt++) {
      await datasource.adjustBalance(
        accountId: 'checking',
        delta: 250,
        mutationId: 'manual-entry-edit-1',
        updatedAt: now,
        accountEntry: entry,
      );
    }

    final accountData =
        (await firestore.collection('accounts').doc('checking').get()).data()!;
    final entryData =
        (await firestore.collection('account_entries').doc('edit-1').get())
            .data()!;
    expect(accountData['currentBalance'], 1250);
    expect(entryData['previousBalance'], 1000);
    expect(entryData['newBalance'], 1250);
    expect(entryData['synced'], true);
  });

  test(
    'manual balance edit sets its target after a concurrent change',
    () async {
      await datasource.createAccount(account('checking', 1100));
      final entry = ManualDepositDto(
        id: 'edit-concurrent',
        userId: 'user-a',
        accountId: 'checking',
        amount: -400,
        description: 'Manual balance edit',
        previousBalance: 1000,
        newBalance: 600,
        isBalanceEdit: true,
        createdAt: now,
      );

      await datasource.adjustBalance(
        accountId: 'checking',
        delta: -400,
        mutationId: 'manual-entry-edit-concurrent',
        updatedAt: now,
        accountEntry: entry,
      );

      final accountData =
          (await firestore.collection('accounts').doc('checking').get())
              .data()!;
      final entryData =
          (await firestore
                  .collection('account_entries')
                  .doc('edit-concurrent')
                  .get())
              .data()!;
      expect(accountData['currentBalance'], 600);
      expect(entryData['previousBalance'], 1100);
      expect(entryData['newBalance'], 600);
      expect(entryData['amount'], -500);
    },
  );

  test('transferBalance updates source and destination in one batch', () async {
    await datasource.createAccount(account('checking', 1000));
    await datasource.createAccount(account('savings', 500));

    await datasource.transferBalance(
      fromAccountId: 'checking',
      toAccountId: 'savings',
      amount: 300,
      fromMutationId: 'transfer-1-debit',
      toMutationId: 'transfer-1-credit',
      updatedAt: now.add(const Duration(minutes: 1)),
    );
    await datasource.transferBalance(
      fromAccountId: 'checking',
      toAccountId: 'savings',
      amount: 300,
      fromMutationId: 'transfer-1-debit',
      toMutationId: 'transfer-1-credit',
      updatedAt: now.add(const Duration(minutes: 2)),
    );

    final checking =
        (await firestore.collection('accounts').doc('checking').get()).data()!;
    final savings =
        (await firestore.collection('accounts').doc('savings').get()).data()!;
    expect(checking['currentBalance'], 700);
    expect(savings['currentBalance'], 800);
  });

  test(
    'metadata update never overwrites a concurrently changed balance',
    () async {
      await datasource.createAccount(account('checking', 1000));
      await datasource.adjustBalance(
        accountId: 'checking',
        delta: 250,
        mutationId: 'income-1',
        updatedAt: now.add(const Duration(minutes: 1)),
      );

      await datasource.updateAccount(
        account('checking', 1000).copyWith(accountName: 'Renamed'),
      );

      final data =
          (await firestore.collection('accounts').doc('checking').get())
              .data()!;
      expect(data['accountName'], 'Renamed');
      expect(data['currentBalance'], 1250);
    },
  );
}
