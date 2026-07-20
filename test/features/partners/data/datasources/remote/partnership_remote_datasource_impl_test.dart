import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:famxpense/features/partners/data/datasources/remote/partnership_remote_datasource_impl.dart';
import 'package:famxpense/features/partners/data/transformers/dtos/partnership_remote_dto.dart';

void main() {
  group('PartnershipRemoteDatasourceImpl', () {
    late FakeFirebaseFirestore fakeFirestore;
    late PartnershipRemoteDatasourceImpl datasource;

    final now = DateTime(2026, 7, 1, 12, 0, 0).toUtc();

    setUp(() {
      fakeFirestore = FakeFirebaseFirestore();
      datasource = PartnershipRemoteDatasourceImpl(firestore: fakeFirestore);
    });

    group('sendRequest', () {
      test('creates document in partnerships collection', () async {
        final dto = PartnershipRemoteDto(
          id: 'p-1',
          senderId: 'user-a',
          receiverId: 'user-b',
          senderEmail: 'a@test.com',
          receiverEmail: 'b@test.com',
          senderNickname: 'UserA',
          receiverNickname: 'UserB',
          status: 'pending',
          createdAt: now,
          updatedAt: now,
          participantIds: ['user-a', 'user-b'],
        );

        await datasource.sendRequest(dto);

        final doc = await fakeFirestore.collection('partnerships').doc('p-1').get();
        expect(doc.exists, true);
        expect(doc.data()!['participantIds'], ['user-a', 'user-b']);
      });
    });

    group('updateRequest', () {
      test('updates existing partnership document', () async {
        final original = PartnershipRemoteDto(
          id: 'p-2',
          senderId: 'user-a',
          receiverId: 'user-b',
          senderEmail: 'a@test.com',
          receiverEmail: 'b@test.com',
          senderNickname: 'UserA',
          receiverNickname: 'UserB',
          status: 'pending',
          createdAt: now,
          updatedAt: now,
          participantIds: ['user-a', 'user-b'],
        );

        await datasource.sendRequest(original);

        final updated = original.copyWith(status: 'accepted', updatedAt: now.add(const Duration(hours: 1)));
        await datasource.updateRequest(updated);

        final doc = await fakeFirestore.collection('partnerships').doc('p-2').get();
        expect(doc.data()!['status'], 'accepted');
      });
    });

    group('deletePartnership', () {
      test('deletes document from partnerships collection', () async {
        final dto = PartnershipRemoteDto(
          id: 'p-3',
          senderId: 'user-a',
          receiverId: 'user-b',
          senderEmail: 'a@test.com',
          receiverEmail: 'b@test.com',
          senderNickname: 'UserA',
          receiverNickname: 'UserB',
          status: 'pending',
          createdAt: now,
          updatedAt: now,
          participantIds: ['user-a', 'user-b'],
        );

        await datasource.sendRequest(dto);
        await datasource.deletePartnership('p-3');

        final doc = await fakeFirestore.collection('partnerships').doc('p-3').get();
        expect(doc.exists, false);
      });
    });

    group('getPartnerships', () {
      test('returns partnerships where user is in participantIds', () async {
        final p1 = PartnershipRemoteDto(
          id: 'p-4',
          senderId: 'user-a',
          receiverId: 'user-b',
          senderEmail: 'a@test.com',
          receiverEmail: 'b@test.com',
          senderNickname: 'UserA',
          receiverNickname: 'UserB',
          status: 'accepted',
          createdAt: now,
          updatedAt: now,
          participantIds: ['user-a', 'user-b'],
        );
        final p2 = PartnershipRemoteDto(
          id: 'p-5',
          senderId: 'user-c',
          receiverId: 'user-a',
          senderEmail: 'c@test.com',
          receiverEmail: 'a@test.com',
          senderNickname: 'UserC',
          receiverNickname: 'UserA',
          status: 'pending',
          createdAt: now,
          updatedAt: now,
          participantIds: ['user-c', 'user-a'],
        );
        final p3 = PartnershipRemoteDto(
          id: 'p-6',
          senderId: 'user-c',
          receiverId: 'user-d',
          senderEmail: 'c@test.com',
          receiverEmail: 'd@test.com',
          senderNickname: 'UserC',
          receiverNickname: 'UserD',
          status: 'pending',
          createdAt: now,
          updatedAt: now,
          participantIds: ['user-c', 'user-d'],
        );

        await datasource.sendRequest(p1);
        await datasource.sendRequest(p2);
        await datasource.sendRequest(p3);

        final results = await datasource.getPartnerships(userId: 'user-a');

        expect(results.length, 2);
        expect(results.map((p) => p.id).toSet(), {'p-4', 'p-5'});
      });

      test('returns empty list when user has no partnerships', () async {
        final results = await datasource.getPartnerships(userId: 'user-a');
        expect(results, isEmpty);
      });
    });
  });
}
