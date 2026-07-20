import 'package:flutter_test/flutter_test.dart';
import 'package:famxpense/shared/data/transformers/dtos/settlement/settlement_dto.dart';
import 'package:famxpense/shared/data/transformers/mappers/settlement/settlement_mapper.dart';
import 'package:famxpense/shared/domain/entities/settlement/settlement_entity.dart';
import 'package:famxpense/shared/enums/settlement_status.dart';

void main() {
  final now = DateTime(2026, 7, 1, 12, 0, 0).toUtc();

  group('SettlementDtoMapper', () {
    test('toEntity maps all fields from DTO (participantIds defaults to [])', () {
      final dto = SettlementDto(
        id: 'dto-1',
        fromUserId: 'user-a',
        toUserId: 'user-b',
        amount: 100.0,
        status: SettlementStatus.pending,
        createdAt: now,
        confirmedAt: null,
        relatedExpenseIds: ['exp-1'],
        accountId: 'acc-1',
      );

      final entity = dto.toEntity();

      expect(entity.id, dto.id);
      expect(entity.fromUserId, dto.fromUserId);
      expect(entity.toUserId, dto.toUserId);
      expect(entity.amount, dto.amount);
      expect(entity.status, dto.status);
      expect(entity.createdAt, dto.createdAt);
      expect(entity.confirmedAt, dto.confirmedAt);
      expect(entity.relatedExpenseIds, dto.relatedExpenseIds);
      expect(entity.accountId, dto.accountId);
      expect(entity.participantIds, []);
    });

    test('toEntity with no optional fields', () {
      final dto = SettlementDto(
        id: 'dto-2',
        fromUserId: 'user-a',
        toUserId: 'user-b',
        amount: 50.0,
        status: SettlementStatus.pending,
        createdAt: now,
      );

      final entity = dto.toEntity();

      expect(entity.id, dto.id);
      expect(entity.confirmedAt, isNull);
      expect(entity.relatedExpenseIds, isNull);
      expect(entity.accountId, isNull);
      expect(entity.participantIds, []);
    });
  });

  group('SettlementEntityMapper', () {
    test('toDto maps all fields from entity', () {
      final entity = SettlementEntity(
        id: 'entity-1',
        fromUserId: 'user-a',
        toUserId: 'user-b',
        amount: 100.0,
        status: SettlementStatus.confirmed,
        createdAt: now,
        confirmedAt: now,
        relatedExpenseIds: ['exp-1'],
        accountId: 'acc-1',
        participantIds: ['user-a', 'user-b'],
      );

      final dto = entity.toDto();

      expect(dto.id, entity.id);
      expect(dto.fromUserId, entity.fromUserId);
      expect(dto.toUserId, entity.toUserId);
      expect(dto.amount, entity.amount);
      expect(dto.status, entity.status);
      expect(dto.createdAt, entity.createdAt);
      expect(dto.confirmedAt, entity.confirmedAt);
      expect(dto.relatedExpenseIds, entity.relatedExpenseIds);
      expect(dto.accountId, entity.accountId);
    });

    test('toDto does NOT include participantIds (Firestore-only field)', () {
      final entity = SettlementEntity(
        id: 'entity-2',
        fromUserId: 'user-a',
        toUserId: 'user-b',
        amount: 100.0,
        status: SettlementStatus.pending,
        createdAt: now,
        participantIds: ['user-a', 'user-b'],
      );

      final dto = entity.toDto();

      final dtoJson = dto.toJson();
      expect(dtoJson.containsKey('participantIds'), false);
    });
  });

  group('SettlementDto <-> SettlementEntity roundtrip', () {
    test('DTO -> Entity -> DTO preserves all DTO fields', () {
      final originalDto = SettlementDto(
        id: 'dto-3',
        fromUserId: 'user-a',
        toUserId: 'user-b',
        amount: 75.0,
        status: SettlementStatus.rejected,
        createdAt: now,
        confirmedAt: null,
        relatedExpenseIds: null,
        accountId: null,
      );

      final entity = originalDto.toEntity();
      final roundtripDto = entity.toDto();

      expect(roundtripDto.id, originalDto.id);
      expect(roundtripDto.fromUserId, originalDto.fromUserId);
      expect(roundtripDto.toUserId, originalDto.toUserId);
      expect(roundtripDto.amount, originalDto.amount);
      expect(roundtripDto.status, originalDto.status);
      expect(roundtripDto.createdAt, originalDto.createdAt);
      expect(roundtripDto.confirmedAt, originalDto.confirmedAt);
      expect(roundtripDto.relatedExpenseIds, originalDto.relatedExpenseIds);
      expect(roundtripDto.accountId, originalDto.accountId);
      expect(roundtripDto, equals(originalDto));
    });
  });
}
