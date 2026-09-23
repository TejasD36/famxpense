import 'package:flutter_test/flutter_test.dart';
import 'package:famxpense/shared/data/transformers/dtos/income/income_dto.dart';
import 'package:famxpense/shared/data/transformers/mappers/income/income_mapper.dart';
import 'package:famxpense/shared/domain/entities/income/income_entity.dart';
import 'package:famxpense/shared/enums/income_source.dart';
import 'package:famxpense/shared/enums/sync_status.dart';

void main() {
  final now = DateTime(2026, 7, 27, 12, 0, 0).toUtc();

  group('IncomeDtoMapper', () {
    test('toEntity maps all fields', () {
      final dto = IncomeDto(
        id: 'inc-1',
        userId: 'user-a',
        accountId: 'acct-1',
        amount: 5000.0,
        source: IncomeSource.salary,
        description: 'Salary',
        createdAt: now,
        updatedAt: now,
        syncStatus: SyncStatus.pending,
      );

      final entity = dto.toEntity();

      expect(entity.id, dto.id);
      expect(entity.userId, dto.userId);
      expect(entity.accountId, dto.accountId);
      expect(entity.amount, dto.amount);
      expect(entity.source, dto.source);
      expect(entity.description, dto.description);
      expect(entity.createdAt, dto.createdAt);
      expect(entity.updatedAt, dto.updatedAt);
      expect(entity.syncStatus, dto.syncStatus);
    });
  });

  group('IncomeEntityMapper', () {
    test('toDto maps all fields', () {
      final entity = IncomeEntity(
        id: 'inc-1',
        userId: 'user-a',
        accountId: 'acct-1',
        amount: 5000.0,
        source: IncomeSource.salary,
        description: 'Salary',
        createdAt: now,
        updatedAt: now,
        syncStatus: SyncStatus.pending,
      );

      final dto = entity.toDto();

      expect(dto.id, entity.id);
      expect(dto.userId, entity.userId);
      expect(dto.accountId, entity.accountId);
      expect(dto.amount, entity.amount);
      expect(dto.source, entity.source);
      expect(dto.description, entity.description);
      expect(dto.createdAt, entity.createdAt);
      expect(dto.updatedAt, entity.updatedAt);
      expect(dto.syncStatus, entity.syncStatus);
    });
  });

  group('IncomeDto <-> IncomeEntity roundtrip', () {
    test('DTO -> Entity -> DTO preserves all fields', () {
      final originalDto = IncomeDto(
        id: 'inc-2',
        userId: 'user-b',
        accountId: 'acct-2',
        amount: 3000.0,
        source: IncomeSource.freelance,
        description: 'Freelance project',
        createdAt: now,
        updatedAt: now,
        syncStatus: SyncStatus.synced,
      );

      final entity = originalDto.toEntity();
      final roundtripDto = entity.toDto();

      expect(roundtripDto.id, originalDto.id);
      expect(roundtripDto.userId, originalDto.userId);
      expect(roundtripDto.accountId, originalDto.accountId);
      expect(roundtripDto.amount, originalDto.amount);
      expect(roundtripDto.source, originalDto.source);
      expect(roundtripDto.description, originalDto.description);
      expect(roundtripDto.createdAt, originalDto.createdAt);
      expect(roundtripDto.updatedAt, originalDto.updatedAt);
      expect(roundtripDto.syncStatus, originalDto.syncStatus);
    });
  });
}
