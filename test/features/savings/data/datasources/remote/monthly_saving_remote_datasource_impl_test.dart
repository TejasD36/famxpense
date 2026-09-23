import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:famxpense/features/savings/data/datasources/remote/monthly_saving_remote_datasource_impl.dart';
import 'package:famxpense/shared/data/transformers/dtos/savings/monthly_saving_dto.dart';
import 'package:famxpense/shared/enums/sync_status.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FakeFirebaseFirestore firestore;
  late MonthlySavingRemoteDatasourceImpl datasource;
  final now = DateTime(2026, 7, 31).toUtc();

  MonthlySavingDto snapshot(String id, String userId) => MonthlySavingDto(
    id: id,
    accountId: 'savings-$userId',
    year: 2026,
    month: 7,
    goalAmount: 5000,
    savedAmount: 1000,
    openingBalance: 10000,
    closingBalance: 11000,
    achievementPercent: 20,
    userId: userId,
    syncStatus: SyncStatus.synced,
    updatedAt: now,
  );

  setUp(() {
    firestore = FakeFirebaseFirestore();
    datasource = MonthlySavingRemoteDatasourceImpl(firestore: firestore);
  });

  test(
    'upserts snapshots and fetches only the current owner records',
    () async {
      await datasource.saveSnapshot(snapshot('snapshot-a', 'user-a'));
      await datasource.saveSnapshot(snapshot('snapshot-b', 'user-b'));

      final results = await datasource.fetchSnapshots(userId: 'user-a');

      expect(results, hasLength(1));
      expect(results.single.id, 'snapshot-a');
      expect(results.single.updatedAt, now);
    },
  );

  test(
    'updating the same ID replaces its values without creating a duplicate',
    () async {
      final original = snapshot('snapshot-a', 'user-a');
      await datasource.saveSnapshot(original);
      await datasource.saveSnapshot(
        original.copyWith(
          closingBalance: 12000,
          savedAmount: 2000,
          updatedAt: now.add(const Duration(minutes: 1)),
        ),
      );

      final results = await datasource.fetchSnapshots(userId: 'user-a');

      expect(results, hasLength(1));
      expect(results.single.closingBalance, 12000);
    },
  );
}
