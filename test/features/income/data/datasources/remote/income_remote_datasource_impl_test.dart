import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:famxpense/features/income/data/datasources/remote/income_remote_datasource_impl.dart';
import 'package:famxpense/shared/data/transformers/dtos/income/income_dto.dart';
import 'package:famxpense/shared/enums/income_source.dart';
import 'package:famxpense/shared/enums/sync_status.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FakeFirebaseFirestore firestore;
  late IncomeRemoteDatasourceImpl datasource;
  final now = DateTime(2026, 7, 31).toUtc();

  IncomeDto income(String id, String userId) => IncomeDto(
    id: id,
    userId: userId,
    accountId: 'account-$userId',
    amount: 5000,
    source: IncomeSource.salary,
    description: 'Salary',
    createdAt: now,
    updatedAt: now,
    syncStatus: SyncStatus.synced,
  );

  setUp(() {
    firestore = FakeFirebaseFirestore();
    datasource = IncomeRemoteDatasourceImpl(firestore: firestore);
  });

  test('creates, filters by owner, and round-trips sync metadata', () async {
    await datasource.createIncome(income('income-a', 'user-a'));
    await datasource.createIncome(income('income-b', 'user-b'));

    final results = await datasource.fetchIncomes(userId: 'user-a');

    expect(results, hasLength(1));
    expect(results.single.id, 'income-a');
    expect(results.single.syncStatus, SyncStatus.synced);
    expect(results.single.isDeleted, false);
  });

  test('deletes the requested income document', () async {
    await datasource.createIncome(income('income-a', 'user-a'));

    await datasource.deleteIncome('income-a');

    expect(
      (await firestore.collection('incomes').doc('income-a').get()).exists,
      false,
    );
  });
}
