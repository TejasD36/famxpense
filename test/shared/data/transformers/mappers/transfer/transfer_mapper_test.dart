import 'package:flutter_test/flutter_test.dart';
import 'package:famxpense/shared/data/transformers/dtos/transfer/transfer_dto.dart';
import 'package:famxpense/shared/data/transformers/mappers/transfer/transfer_mapper.dart';
import 'package:famxpense/shared/domain/entities/transfer/transfer_entity.dart';
import 'package:famxpense/shared/enums/sync_status.dart';

void main() {
  final now = DateTime(2026, 7, 27, 12, 0, 0).toUtc();

  group('TransferDtoMapper', () {
    test('toEntity maps all fields', () {
      final dto = TransferDto(
        id: 'tr-1',
        fromAccountId: 'acct-checking',
        toAccountId: 'acct-savings',
        fromUserId: 'user-a',
        toUserId: 'user-a',
        amount: 3000.0,
        description: 'Savings allocation',
        createdAt: now,
        updatedAt: now,
        syncStatus: SyncStatus.synced,
      );

      final entity = dto.toEntity();

      expect(entity.id, dto.id);
      expect(entity.fromAccountId, dto.fromAccountId);
      expect(entity.toAccountId, dto.toAccountId);
      expect(entity.fromUserId, dto.fromUserId);
      expect(entity.toUserId, dto.toUserId);
      expect(entity.amount, dto.amount);
      expect(entity.description, dto.description);
      expect(entity.createdAt, dto.createdAt);
      expect(entity.updatedAt, dto.updatedAt);
      expect(entity.syncStatus, dto.syncStatus);
    });
  });

  group('TransferEntityMapper', () {
    test('toDto maps all fields', () {
      final entity = TransferEntity(
        id: 'tr-1',
        fromAccountId: 'acct-checking',
        toAccountId: 'acct-savings',
        fromUserId: 'user-a',
        toUserId: 'user-a',
        amount: 3000.0,
        description: 'Savings allocation',
        createdAt: now,
        updatedAt: now,
      );

      final dto = entity.toDto();

      expect(dto.id, entity.id);
      expect(dto.fromAccountId, entity.fromAccountId);
      expect(dto.toAccountId, entity.toAccountId);
      expect(dto.fromUserId, entity.fromUserId);
      expect(dto.toUserId, entity.toUserId);
      expect(dto.amount, entity.amount);
      expect(dto.description, entity.description);
      expect(dto.createdAt, entity.createdAt);
      expect(dto.updatedAt, entity.updatedAt);
      expect(dto.syncStatus, entity.syncStatus);
    });
  });

  group('TransferDto <-> TransferEntity roundtrip', () {
    test('DTO -> Entity -> DTO preserves all fields', () {
      final originalDto = TransferDto(
        id: 'tr-2',
        fromAccountId: 'acct-a',
        toAccountId: 'acct-b',
        fromUserId: 'user-a',
        toUserId: 'user-b',
        amount: 1500.0,
        description: 'Payment',
        createdAt: now,
        updatedAt: now,
      );

      final entity = originalDto.toEntity();
      final roundtripDto = entity.toDto();

      expect(roundtripDto.id, originalDto.id);
      expect(roundtripDto.fromAccountId, originalDto.fromAccountId);
      expect(roundtripDto.toAccountId, originalDto.toAccountId);
      expect(roundtripDto.fromUserId, originalDto.fromUserId);
      expect(roundtripDto.toUserId, originalDto.toUserId);
      expect(roundtripDto.amount, originalDto.amount);
      expect(roundtripDto.description, originalDto.description);
      expect(roundtripDto.createdAt, originalDto.createdAt);
      expect(roundtripDto.updatedAt, originalDto.updatedAt);
      expect(roundtripDto.syncStatus, originalDto.syncStatus);
    });
  });
}
