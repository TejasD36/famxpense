import 'package:flutter_test/flutter_test.dart';
import 'package:famxpense/shared/domain/entities/partnership/partnership_entity.dart';
import 'package:famxpense/shared/enums/partnership_status.dart';

void main() {
  final now = DateTime(2026, 7, 1, 12, 0, 0).toUtc();

  group('PartnershipEntity', () {
    test('creates with all fields', () {
      final entity = PartnershipEntity(
        id: 'p-1',
        senderId: 'user-a',
        senderEmail: 'a@test.com',
        senderNickname: 'UserA',
        receiverId: 'user-b',
        receiverEmail: 'b@test.com',
        receiverNickname: 'UserB',
        status: PartnershipStatus.pending,
        createdAt: now,
        updatedAt: now,
      );

      expect(entity.id, 'p-1');
      expect(entity.senderId, 'user-a');
      expect(entity.receiverId, 'user-b');
      expect(entity.senderNickname, 'UserA');
      expect(entity.receiverNickname, 'UserB');
      expect(entity.status, PartnershipStatus.pending);
    });

    test('toJson / fromJson roundtrip', () {
      final entity = PartnershipEntity(
        id: 'p-2',
        senderId: 'user-a',
        senderEmail: 'a@test.com',
        senderNickname: 'UserA',
        receiverId: 'user-b',
        receiverEmail: 'b@test.com',
        receiverNickname: 'UserB',
        status: PartnershipStatus.accepted,
        createdAt: now,
        updatedAt: now,
      );

      final json = entity.toJson();
      final restored = PartnershipEntity.fromJson(json);

      expect(restored.id, entity.id);
      expect(restored.senderId, entity.senderId);
      expect(restored.receiverId, entity.receiverId);
      expect(restored.status, entity.status);
    });

    test('copyWith updates fields', () {
      final entity = PartnershipEntity(
        id: 'p-1',
        senderId: 'user-a',
        senderEmail: 'a@test.com',
        senderNickname: 'UserA',
        receiverId: 'user-b',
        receiverEmail: 'b@test.com',
        receiverNickname: 'UserB',
        status: PartnershipStatus.pending,
        createdAt: now,
        updatedAt: now,
      );

      final updated = entity.copyWith(status: PartnershipStatus.accepted);
      expect(updated.status, PartnershipStatus.accepted);
      expect(updated.id, 'p-1');
    });

    test('equality works', () {
      final a = PartnershipEntity(
        id: 'p-1',
        senderId: 'user-a',
        senderEmail: 'a@test.com',
        senderNickname: 'UserA',
        receiverId: 'user-b',
        receiverEmail: 'b@test.com',
        receiverNickname: 'UserB',
        status: PartnershipStatus.pending,
        createdAt: now,
        updatedAt: now,
      );
      final b = PartnershipEntity(
        id: 'p-1',
        senderId: 'user-a',
        senderEmail: 'a@test.com',
        senderNickname: 'UserA',
        receiverId: 'user-b',
        receiverEmail: 'b@test.com',
        receiverNickname: 'UserB',
        status: PartnershipStatus.pending,
        createdAt: now,
        updatedAt: now,
      );

      expect(a, equals(b));
    });
  });
}
