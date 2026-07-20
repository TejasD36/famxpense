import 'package:flutter_test/flutter_test.dart';
import 'package:famxpense/features/partners/data/transformers/dtos/partnership_remote_dto.dart';

void main() {
  final now = DateTime(2026, 7, 1, 12, 0, 0).toUtc();

  group('PartnershipRemoteDto', () {
    test('creates with all fields including participantIds', () {
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

      expect(dto.participantIds, ['user-a', 'user-b']);
    });

    test('participantIds defaults to empty list', () {
      final dto = PartnershipRemoteDto(
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
      );

      expect(dto.participantIds, []);
    });

    test('toJson includes participantIds', () {
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

      final json = dto.toJson();

      expect(json['participantIds'], ['user-a', 'user-b']);
    });

    test('fromJson parses participantIds', () {
      final json = {
        'id': 'p-1',
        'senderId': 'user-a',
        'receiverId': 'user-b',
        'senderEmail': 'a@test.com',
        'receiverEmail': 'b@test.com',
        'senderNickname': 'UserA',
        'receiverNickname': 'UserB',
        'status': 'accepted',
        'createdAt': now.toIso8601String(),
        'updatedAt': now.toIso8601String(),
        'participantIds': ['user-a', 'user-b'],
      };

      final dto = PartnershipRemoteDto.fromJson(json);

      expect(dto.participantIds, ['user-a', 'user-b']);
    });

    test('fromJson defaults participantIds when missing', () {
      final json = {
        'id': 'p-2',
        'senderId': 'user-a',
        'receiverId': 'user-b',
        'senderEmail': 'a@test.com',
        'receiverEmail': 'b@test.com',
        'senderNickname': 'UserA',
        'receiverNickname': 'UserB',
        'status': 'pending',
        'createdAt': now.toIso8601String(),
        'updatedAt': now.toIso8601String(),
      };

      final dto = PartnershipRemoteDto.fromJson(json);

      expect(dto.participantIds, []);
    });

    test('JSON roundtrip preserves participantIds', () {
      final dto = PartnershipRemoteDto(
        id: 'p-3',
        senderId: 'user-a',
        receiverId: 'user-b',
        senderEmail: 'a@test.com',
        receiverEmail: 'b@test.com',
        senderNickname: 'UserA',
        receiverNickname: 'UserB',
        status: 'rejected',
        createdAt: now,
        updatedAt: now,
        participantIds: ['user-a', 'user-b'],
      );

      final json = dto.toJson();
      final restored = PartnershipRemoteDto.fromJson(json);

      expect(restored, equals(dto));
    });
  });
}
