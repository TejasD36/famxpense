import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:famxpense/features/savings/data/datasources/remote/transfer_remote_datasource_impl.dart';
import 'package:famxpense/shared/data/transformers/dtos/transfer/transfer_dto.dart';
import 'package:famxpense/shared/enums/sync_status.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FakeFirebaseFirestore firestore;
  late TransferRemoteDatasourceImpl datasource;
  final now = DateTime(2026, 7, 31).toUtc();

  TransferDto transfer(String id, String userId) => TransferDto(
    id: id,
    fromAccountId: 'from-$userId',
    toAccountId: 'to-$userId',
    fromUserId: userId,
    toUserId: userId,
    amount: 250,
    description: 'Savings allocation',
    createdAt: now,
    updatedAt: now,
    syncStatus: SyncStatus.synced,
  );

  setUp(() {
    firestore = FakeFirebaseFirestore();
    datasource = TransferRemoteDatasourceImpl(firestore: firestore);
  });

  test(
    'creates transfers and fetches only the current owner records',
    () async {
      await datasource.createTransfer(transfer('transfer-a', 'user-a'));
      await datasource.createTransfer(transfer('transfer-b', 'user-b'));

      final results = await datasource.fetchTransfers(userId: 'user-a');

      expect(results, hasLength(1));
      expect(results.single.id, 'transfer-a');
      expect(results.single.syncStatus, SyncStatus.synced);
    },
  );
}
