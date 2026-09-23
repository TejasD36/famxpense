import 'package:flutter_test/flutter_test.dart';
import 'package:famxpense/shared/data/transformers/dtos/expense/expense_dto.dart';
import 'package:famxpense/shared/data/transformers/dtos/expense/expense_participant_dto.dart';
import 'package:famxpense/shared/data/transformers/mappers/expense/expense_mapper.dart';
import 'package:famxpense/shared/enums/expense_type.dart';
import 'package:famxpense/shared/enums/split_type.dart';
import 'package:famxpense/shared/enums/sync_status.dart';
import 'package:famxpense/features/expenses/data/transformers/mappers/expense_remote_mapper.dart';

void main() {
  final now = DateTime(2026, 7, 21, 12, 0, 0).toUtc();

  final participantDto = ExpenseParticipantDto(
    userId: 'user-b',
    amount: 50.0,
  );

  final expenseDto = ExpenseDto(
    id: 'exp-1',
    title: 'Lunch',
    note: 'At cafe',
    amount: 100.0,
    paidByUserId: 'user-a',
    ownerUserId: 'user-a',
    expenseType: ExpenseType.shared,
    splitType: SplitType.equal,
    participants: [participantDto],
    expenseDate: now,
    createdAt: now,
    updatedAt: now,
    syncStatus: SyncStatus.synced,
    category: 'food',
    latitude: 12.9716,
    longitude: 77.5946,
  );

  group('ExpenseDto <-> ExpenseEntity', () {
    test('toEntity maps all fields including lat/lng', () {
      final entity = expenseDto.toEntity();

      expect(entity.id, expenseDto.id);
      expect(entity.title, expenseDto.title);
      expect(entity.amount, expenseDto.amount);
      expect(entity.latitude, 12.9716);
      expect(entity.longitude, 77.5946);
      expect(entity.category, 'food');
      expect(entity.participants.length, 1);
    });

    test('toDto maps all fields including lat/lng', () {
      final entity = expenseDto.toEntity();
      final dto = entity.toDto();

      expect(dto.id, expenseDto.id);
      expect(dto.title, expenseDto.title);
      expect(dto.amount, expenseDto.amount);
      expect(dto.latitude, 12.9716);
      expect(dto.longitude, 77.5946);
      expect(dto.category, 'food');
    });

    test('DTO -> Entity -> DTO roundtrip', () {
      final entity = expenseDto.toEntity();
      final restoredDto = entity.toDto();

      expect(restoredDto.id, expenseDto.id);
      expect(restoredDto.latitude, expenseDto.latitude);
      expect(restoredDto.longitude, expenseDto.longitude);
      expect(restoredDto.category, expenseDto.category);
    });

    test('handles null lat/lng in DTO', () {
      final dtoNoLocation = expenseDto.copyWith(latitude: null, longitude: null);
      final entity = dtoNoLocation.toEntity();
      expect(entity.latitude, isNull);
      expect(entity.longitude, isNull);
    });
  });

  group('ExpenseEntity <-> ExpenseRemoteDto', () {
    test('toRemoteDto maps lat/lng', () {
      final entity = expenseDto.toEntity();
      final remote = entity.toRemoteDto();

      expect(remote.latitude, 12.9716);
      expect(remote.longitude, 77.5946);
      expect(remote.category, 'food');
      expect(remote.participantIds, ['user-b']);
    });

    test('RemoteDto -> Entity roundtrip', () {
      final entity = expenseDto.toEntity();
      final remote = entity.toRemoteDto();
      final restored = remote.toEntity();

      expect(restored.id, entity.id);
      expect(restored.latitude, entity.latitude);
      expect(restored.longitude, entity.longitude);
      expect(restored.category, entity.category);
      expect(restored.syncStatus, SyncStatus.synced);
    });

    test('handles null lat/lng in RemoteDto', () {
      final entity = expenseDto.toEntity().copyWith(latitude: null, longitude: null);
      final remote = entity.toRemoteDto();
      expect(remote.latitude, isNull);
      expect(remote.longitude, isNull);
    });
  });
}
