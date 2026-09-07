import 'package:famxpense/features/expenses/domain/services/expense_edit_policy.dart';
import 'package:famxpense/shared/domain/entities/expense/expense_entity.dart';
import 'package:famxpense/shared/domain/entities/expense/expense_participant_entity.dart';
import 'package:famxpense/shared/enums/expense_type.dart';
import 'package:famxpense/shared/enums/split_type.dart';
import 'package:famxpense/shared/enums/sync_status.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final createdAt = DateTime.utc(2026, 8, 27, 10);

  ExpenseEntity expense({
    DateTime? created,
    String paidBy = 'user-a',
    String owner = 'user-a',
    bool isDisabled = false,
    List<ExpenseParticipantEntity>? participants,
  }) {
    final resolvedCreated = created ?? createdAt;
    return ExpenseEntity(
      id: 'expense-1',
      title: 'Lunch',
      amount: 100,
      paidByUserId: paidBy,
      ownerUserId: owner,
      expenseType: ExpenseType.shared,
      splitType: SplitType.equal,
      participants:
          participants ??
          const [
            ExpenseParticipantEntity(userId: 'user-a', amount: 50),
            ExpenseParticipantEntity(userId: 'user-b', amount: 50),
          ],
      expenseDate: resolvedCreated,
      createdAt: resolvedCreated,
      updatedAt: resolvedCreated,
      syncStatus: SyncStatus.synced,
      isDisabled: isDisabled,
    );
  }

  ExpenseEditPolicyResult evaluate(Duration age, {ExpenseEntity? item}) {
    return ExpenseEditPolicy.evaluate(
      expense: item ?? expense(),
      currentUserId: 'user-a',
      now: createdAt.add(age),
    );
  }

  test('full edit is allowed at 0, 15, 59, and exactly 60 minutes', () {
    for (final age in [
      Duration.zero,
      const Duration(minutes: 15),
      const Duration(minutes: 59),
      const Duration(minutes: 60),
    ]) {
      final result = evaluate(age);
      expect(result.capability, ExpenseEditCapability.full);
      expect(result.canDelete, isTrue);
    }
  });

  test(
    'full edit is denied after 60 minutes but title and note remain editable',
    () {
      final result = evaluate(const Duration(minutes: 61));

      expect(result.capability, ExpenseEditCapability.metadataOnly);
      expect(result.canEdit, isTrue);
      expect(result.canDelete, isFalse);
    },
  );

  test('non-owner edits are denied', () {
    final result = ExpenseEditPolicy.evaluate(
      expense: expense(),
      currentUserId: 'user-b',
      now: createdAt,
    );

    expect(result.capability, ExpenseEditCapability.none);
    expect(result.canDelete, isFalse);
  });

  test('disabled expenses cannot be edited', () {
    final result = evaluate(Duration.zero, item: expense(isDisabled: true));

    expect(result.capability, ExpenseEditCapability.none);
    expect(result.canDelete, isFalse);
  });

  test('settled expenses are locked to metadata-only edits', () {
    final result = evaluate(
      Duration.zero,
      item: expense(
        participants: [
          const ExpenseParticipantEntity(userId: 'user-a', amount: 50),
          ExpenseParticipantEntity(
            userId: 'user-b',
            amount: 50,
            isSettled: true,
            settledAt: createdAt,
          ),
        ],
      ),
    );

    expect(result.capability, ExpenseEditCapability.metadataOnly);
    expect(result.canDelete, isFalse);
  });
}
