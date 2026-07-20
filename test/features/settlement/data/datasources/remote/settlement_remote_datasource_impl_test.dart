import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:famxpense/features/settlement/data/datasources/remote/settlement_remote_datasource_impl.dart';
import 'package:famxpense/shared/domain/entities/settlement/settlement_entity.dart';
import 'package:famxpense/shared/enums/settlement_status.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SettlementRemoteDatasourceImpl', () {
    late FakeFirebaseFirestore fakeFirestore;
    late SettlementRemoteDatasourceImpl datasource;

    final now = DateTime(2026, 7, 1, 12, 0, 0).toUtc();

    setUp(() {
      fakeFirestore = FakeFirebaseFirestore();
      datasource = SettlementRemoteDatasourceImpl(firestore: fakeFirestore);
    });

    group('_toJson / _fromJson', () {
      test('creates settlement document with participantIds field', () async {
        final settlement = SettlementEntity(
          id: 's-1',
          fromUserId: 'user-a',
          toUserId: 'user-b',
          amount: 100.0,
          status: SettlementStatus.pending,
          createdAt: now,
        );

        await datasource.createSettlement(settlement);

        final doc = await fakeFirestore.collection('settlements').doc('s-1').get();
        final data = doc.data()!;

        expect(data['participantIds'], ['user-a', 'user-b']);
      });

      test('reads back settlement with participantIds', () async {
        final settlement = SettlementEntity(
          id: 's-2',
          fromUserId: 'user-a',
          toUserId: 'user-b',
          amount: 50.0,
          status: SettlementStatus.pending,
          createdAt: now,
        );

        await datasource.createSettlement(settlement);

        final result = await datasource.fetchSettlementById('s-2');
        expect(result, isNotNull);
        expect(result!.participantIds, ['user-a', 'user-b']);
      });
    });

    group('createSettlement', () {
      test('creates settlement document in Firestore', () async {
        final settlement = SettlementEntity(
          id: 's-3',
          fromUserId: 'user-a',
          toUserId: 'user-b',
          amount: 100.0,
          status: SettlementStatus.pending,
          createdAt: now,
        );

        await datasource.createSettlement(settlement);

        final doc = await fakeFirestore.collection('settlements').doc('s-3').get();
        expect(doc.exists, true);
        expect(doc.data()!['amount'], 100.0);
      });
    });

    group('fetchSettlements', () {
      test('returns settlements where user is in participantIds', () async {
        await datasource.createSettlement(
          SettlementEntity(
            id: 's-4',
            fromUserId: 'user-a',
            toUserId: 'user-b',
            amount: 100.0,
            status: SettlementStatus.pending,
            createdAt: now,
          ),
        );
        await datasource.createSettlement(
          SettlementEntity(
            id: 's-5',
            fromUserId: 'user-c',
            toUserId: 'user-a',
            amount: 50.0,
            status: SettlementStatus.confirmed,
            createdAt: now,
          ),
        );
        await datasource.createSettlement(
          SettlementEntity(
            id: 's-6',
            fromUserId: 'user-c',
            toUserId: 'user-d',
            amount: 25.0,
            status: SettlementStatus.pending,
            createdAt: now,
          ),
        );

        final results = await datasource.fetchSettlements(userId: 'user-a');

        expect(results.length, 2);
        expect(results.map((s) => s.id).toSet(), {'s-4', 's-5'});
      });

      test('returns empty list when user has no settlements', () async {
        await datasource.createSettlement(
          SettlementEntity(
            id: 's-7',
            fromUserId: 'user-b',
            toUserId: 'user-c',
            amount: 100.0,
            status: SettlementStatus.pending,
            createdAt: now,
          ),
        );

        final results = await datasource.fetchSettlements(userId: 'user-a');
        expect(results, isEmpty);
      });
    });

    group('fetchSettlementById', () {
      test('returns null for non-existent settlement', () async {
        final result = await datasource.fetchSettlementById('nonexistent');
        expect(result, isNull);
      });
    });

    group('updateSettlementStatus', () {
      test('updates status field', () async {
        final settlement = SettlementEntity(
          id: 's-8',
          fromUserId: 'user-a',
          toUserId: 'user-b',
          amount: 100.0,
          status: SettlementStatus.pending,
          createdAt: now,
        );

        await datasource.createSettlement(settlement);
        await datasource.updateSettlementStatus('s-8', SettlementStatus.confirmed);

        final doc = await fakeFirestore.collection('settlements').doc('s-8').get();
        expect(doc.data()!['status'], 'confirmed');
      });
    });

    group('streamPendingSettlements', () {
      test('streams pending settlements where user is participant', () async {
        await datasource.createSettlement(
          SettlementEntity(
            id: 's-9',
            fromUserId: 'user-a',
            toUserId: 'user-b',
            amount: 100.0,
            status: SettlementStatus.pending,
            createdAt: now,
          ),
        );
        await datasource.createSettlement(
          SettlementEntity(
            id: 's-10',
            fromUserId: 'user-b',
            toUserId: 'user-a',
            amount: 50.0,
            status: SettlementStatus.pending,
            createdAt: now,
          ),
        );
        await datasource.createSettlement(
          SettlementEntity(
            id: 's-11',
            fromUserId: 'user-b',
            toUserId: 'user-a',
            amount: 25.0,
            status: SettlementStatus.confirmed,
            createdAt: now,
          ),
        );

        final stream = datasource.streamPendingSettlements(userId: 'user-a');
        final results = await stream.first;

        expect(results.length, 2);
        expect(results.every((s) => s.status == SettlementStatus.pending), true);
        expect(results.map((s) => s.id).toSet(), {'s-9', 's-10'});
      });

      test('emits empty list when no pending settlements', () async {
        final stream = datasource.streamPendingSettlements(userId: 'user-a');
        final results = await stream.first;
        expect(results, isEmpty);
      });
    });

    group('legacy document support', () {
      test('reads document without participantIds field with fallback', () async {
        await fakeFirestore.collection('settlements').doc('s-legacy').set({
          'id': 's-legacy',
          'fromUserId': 'user-a',
          'toUserId': 'user-b',
          'amount': 100.0,
          'status': 'pending',
          'createdAt': now.toIso8601String(),
        });

        final result = await datasource.fetchSettlementById('s-legacy');
        expect(result, isNotNull);
        expect(result!.participantIds, ['user-a', 'user-b']);
      });
    });
  });
}
