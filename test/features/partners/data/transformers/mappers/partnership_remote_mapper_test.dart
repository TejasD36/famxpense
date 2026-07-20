import 'package:flutter_test/flutter_test.dart';
import 'package:famxpense/features/partners/data/transformers/dtos/partnership_remote_dto.dart';
import 'package:famxpense/features/partners/data/transformers/mappers/partnership_remote_mapper.dart';
import 'package:famxpense/shared/domain/entities/partnership/partnership_entity.dart';
import 'package:famxpense/shared/enums/partnership_status.dart';

void main() {
  final now = DateTime(2026, 7, 1, 12, 0, 0).toUtc();

  group('PartnershipRemoteMapper (entity -> remote DTO)', () {
    test('toRemoteDto populates participantIds from senderId and receiverId', () {
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

      final dto = entity.toRemoteDto();

      expect(dto.participantIds, ['user-a', 'user-b']);
    });

    test('toRemoteDto maps all fields correctly', () {
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

      final dto = entity.toRemoteDto();

      expect(dto.id, entity.id);
      expect(dto.senderId, entity.senderId);
      expect(dto.receiverId, entity.receiverId);
      expect(dto.senderEmail, entity.senderEmail);
      expect(dto.receiverEmail, entity.receiverEmail);
      expect(dto.senderNickname, entity.senderNickname);
      expect(dto.receiverNickname, entity.receiverNickname);
      expect(dto.status, entity.status.name);
      expect(dto.createdAt, entity.createdAt);
      expect(dto.updatedAt, entity.updatedAt);
    });
  });

  group('PartnershipRemoteDtoMapper (remote DTO -> entity)', () {
    test('toEntity maps all fields correctly', () {
      final dto = PartnershipRemoteDto(
        id: 'p-1',
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

      final entity = dto.toEntity();

      expect(entity.id, dto.id);
      expect(entity.senderId, dto.senderId);
      expect(entity.receiverId, dto.receiverId);
      expect(entity.senderEmail, dto.senderEmail);
      expect(entity.receiverEmail, dto.receiverEmail);
      expect(entity.senderNickname, dto.senderNickname);
      expect(entity.receiverNickname, dto.receiverNickname);
      expect(entity.status, PartnershipStatus.accepted);
      expect(entity.createdAt, dto.createdAt);
      expect(entity.updatedAt, dto.updatedAt);
    });

    test('toEntity maps unknown status to pending', () {
      final dto = PartnershipRemoteDto(
        id: 'p-2',
        senderId: 'user-a',
        receiverId: 'user-b',
        senderEmail: 'a@test.com',
        receiverEmail: 'b@test.com',
        senderNickname: 'UserA',
        receiverNickname: 'UserB',
        status: 'unknown_status',
        createdAt: now,
        updatedAt: now,
      );

      final entity = dto.toEntity();

      expect(entity.status, PartnershipStatus.pending);
    });
  });
}
