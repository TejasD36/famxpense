import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:famxpense/features/debt_ledger/data/datasources/remote/debt_ledger_remote_datasource_impl.dart';
import 'package:famxpense/shared/domain/entities/debt_ledger/debt_ledger_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FakeFirebaseFirestore firestore;
  late DebtLedgerRemoteDatasourceImpl datasource;
  final now = DateTime(2026, 7, 31).toUtc();

  setUp(() {
    firestore = FakeFirebaseFirestore();
    datasource = DebtLedgerRemoteDatasourceImpl(firestore: firestore);
  });

  test('applies each debt mutation exactly once', () async {
    await datasource.adjustDebt(
      userA: 'user-a',
      userB: 'user-b',
      delta: -25,
      mutationId: 'expense-1-user-b',
      updatedAt: now,
    );
    await datasource.adjustDebt(
      userA: 'user-a',
      userB: 'user-b',
      delta: -25,
      mutationId: 'expense-1-user-b',
      updatedAt: now.add(const Duration(minutes: 1)),
    );

    final ledgers = await datasource.fetchLedgers(userId: 'user-a');
    expect(ledgers.single.netBalance, -25);
    expect(
      (await firestore
              .collection('debt_ledger_mutations')
              .doc('expense-1-user-b')
              .get())
          .exists,
      true,
    );
  });

  test(
    'saving stale ledger data cannot overwrite an existing balance',
    () async {
      await datasource.adjustDebt(
        userA: 'user-a',
        userB: 'user-b',
        delta: 40,
        mutationId: 'mutation-1',
        updatedAt: now,
      );

      await datasource.saveLedger(
        DebtLedgerEntity(
          id: 'user-a_user-b',
          userA: 'user-a',
          userB: 'user-b',
          netBalance: 999,
          updatedAt: now.add(const Duration(minutes: 1)),
        ),
      );

      final ledgers = await datasource.fetchLedgers(userId: 'user-a');
      expect(ledgers.single.netBalance, 40);
    },
  );
}
