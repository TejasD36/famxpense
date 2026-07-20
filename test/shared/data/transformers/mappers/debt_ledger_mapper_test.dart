import 'package:flutter_test/flutter_test.dart';
import 'package:famxpense/shared/data/transformers/dtos/debt_ledger/debt_ledger_dto.dart';
import 'package:famxpense/shared/data/transformers/mappers/debt_ledger/debt_ledger_mapper.dart';
import 'package:famxpense/shared/domain/entities/debt_ledger/debt_ledger_entity.dart';

void main() {
  final now = DateTime(2026, 7, 1, 12, 0, 0).toUtc();

  group('DebtLedgerDtoMapper', () {
    test('toEntity populates participantIds from userA and userB', () {
      final dto = DebtLedgerDto(
        id: 'dto-1',
        userA: 'user-a',
        userB: 'user-b',
        netBalance: 100.0,
        updatedAt: now,
      );

      final entity = dto.toEntity();

      expect(entity.participantIds, ['user-a', 'user-b']);
      expect(entity.id, dto.id);
      expect(entity.userA, dto.userA);
      expect(entity.userB, dto.userB);
      expect(entity.netBalance, dto.netBalance);
    });
  });

  group('DebtLedgerEntityMapper', () {
    test('toDto does NOT include participantIds', () {
      final entity = DebtLedgerEntity(
        id: 'entity-1',
        userA: 'user-a',
        userB: 'user-b',
        netBalance: 100.0,
        updatedAt: now,
        participantIds: ['user-a', 'user-b'],
      );

      final dto = entity.toDto();

      expect(dto.id, entity.id);
      expect(dto.userA, entity.userA);
      expect(dto.userB, entity.userB);
      expect(dto.netBalance, entity.netBalance);

      final dtoJson = dto.toJson();
      expect(dtoJson.containsKey('participantIds'), false);
    });
  });

  group('DebtLedgerDto <-> DebtLedgerEntity roundtrip', () {
    test('DTO -> Entity -> DTO preserves all DTO fields', () {
      final originalDto = DebtLedgerDto(
        id: 'dto-2',
        userA: 'user-a',
        userB: 'user-b',
        netBalance: -50.0,
        updatedAt: now,
      );

      final entity = originalDto.toEntity();
      final roundtripDto = entity.toDto();

      expect(roundtripDto.id, originalDto.id);
      expect(roundtripDto.userA, originalDto.userA);
      expect(roundtripDto.userB, originalDto.userB);
      expect(roundtripDto.netBalance, originalDto.netBalance);
    });
  });
}
