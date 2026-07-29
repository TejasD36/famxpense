import 'package:flutter_test/flutter_test.dart';
import 'package:famxpense/shared/data/transformers/dtos/savings/monthly_saving_dto.dart';
import 'package:famxpense/shared/data/transformers/mappers/savings/monthly_saving_mapper.dart';
import 'package:famxpense/shared/domain/entities/savings/monthly_saving_entity.dart';

void main() {
  group('MonthlySavingDtoMapper', () {
    test('toEntity maps all fields', () {
      final dto = MonthlySavingDto(
        id: 'ms-1',
        accountId: 'acct-savings-1',
        year: 2026,
        month: 7,
        goalAmount: 10000.0,
        savedAmount: 7000.0,
        openingBalance: 0.0,
        closingBalance: 7000.0,
        achievementPercent: 70.0,
        isCompleted: false,
        userId: 'user-a',
      );

      final entity = dto.toEntity();

      expect(entity.id, dto.id);
      expect(entity.accountId, dto.accountId);
      expect(entity.year, dto.year);
      expect(entity.month, dto.month);
      expect(entity.goalAmount, dto.goalAmount);
      expect(entity.savedAmount, dto.savedAmount);
      expect(entity.openingBalance, dto.openingBalance);
      expect(entity.closingBalance, dto.closingBalance);
      expect(entity.achievementPercent, dto.achievementPercent);
      expect(entity.isCompleted, dto.isCompleted);
    });
  });

  group('MonthlySavingEntityMapper', () {
    test('toDto maps all fields', () {
      final entity = MonthlySavingEntity(
        id: 'ms-1',
        accountId: 'acct-savings-1',
        year: 2026,
        month: 7,
        goalAmount: 10000.0,
        savedAmount: 7000.0,
        openingBalance: 0.0,
        closingBalance: 7000.0,
        achievementPercent: 70.0,
        userId: 'user-a',
      );

      final dto = entity.toDto();

      expect(dto.id, entity.id);
      expect(dto.accountId, entity.accountId);
      expect(dto.year, entity.year);
      expect(dto.month, entity.month);
      expect(dto.goalAmount, entity.goalAmount);
      expect(dto.savedAmount, entity.savedAmount);
      expect(dto.openingBalance, entity.openingBalance);
      expect(dto.closingBalance, entity.closingBalance);
      expect(dto.achievementPercent, entity.achievementPercent);
      expect(dto.isCompleted, entity.isCompleted);
    });
  });

  group('MonthlySavingDto <-> MonthlySavingEntity roundtrip', () {
    test('DTO -> Entity -> DTO preserves all fields', () {
      final originalDto = MonthlySavingDto(
        id: 'ms-2',
        accountId: 'acct-savings-2',
        year: 2026,
        month: 8,
        goalAmount: 5000.0,
        savedAmount: 2000.0,
        openingBalance: 7000.0,
        closingBalance: 9000.0,
        achievementPercent: 40.0,
        userId: 'user-a',
      );

      final entity = originalDto.toEntity();
      final roundtripDto = entity.toDto();

      expect(roundtripDto.id, originalDto.id);
      expect(roundtripDto.accountId, originalDto.accountId);
      expect(roundtripDto.year, originalDto.year);
      expect(roundtripDto.month, originalDto.month);
      expect(roundtripDto.goalAmount, originalDto.goalAmount);
      expect(roundtripDto.savedAmount, originalDto.savedAmount);
      expect(roundtripDto.openingBalance, originalDto.openingBalance);
      expect(roundtripDto.closingBalance, originalDto.closingBalance);
      expect(roundtripDto.achievementPercent, originalDto.achievementPercent);
    });
  });
}
