import '../../xcore.dart';

enum ExpenseEditCapability { none, metadataOnly, full }

class ExpenseEditPolicyResult {
  const ExpenseEditPolicyResult({
    required this.capability,
    required this.canDelete,
    required this.message,
    this.fullEditExpiresAt,
  });

  final ExpenseEditCapability capability;
  final bool canDelete;
  final String message;
  final DateTime? fullEditExpiresAt;

  bool get canEdit => capability != ExpenseEditCapability.none;
  bool get canFullEdit => capability == ExpenseEditCapability.full;
}

class ExpenseEditPolicy {
  static const correctionWindow = Duration(hours: 1);

  static ExpenseEditPolicyResult evaluate({
    required ExpenseEntity expense,
    required String? currentUserId,
    DateTime? now,
  }) {
    if (expense.isDisabled) {
      return const ExpenseEditPolicyResult(
        capability: ExpenseEditCapability.none,
        canDelete: false,
        message: 'This expense was deleted and cannot be changed.',
      );
    }

    if (currentUserId == null ||
        expense.paidByUserId != currentUserId ||
        expense.ownerUserId != currentUserId) {
      return const ExpenseEditPolicyResult(
        capability: ExpenseEditCapability.none,
        canDelete: false,
        message: 'Only the payer can edit this expense.',
      );
    }

    final hasSettledParticipants = expense.participants.any(
      (participant) => participant.isSettled || participant.settledAt != null,
    );
    if (hasSettledParticipants) {
      return const ExpenseEditPolicyResult(
        capability: ExpenseEditCapability.metadataOnly,
        canDelete: false,
        message: 'Only title and note can be changed.',
      );
    }

    final resolvedNow = (now ?? DateTime.now()).toUtc();
    final createdAt = expense.createdAt.toUtc();
    final age = resolvedNow.difference(createdAt);
    final inCorrectionWindow = !age.isNegative && age <= correctionWindow;

    if (inCorrectionWindow) {
      final expiresAt = createdAt.add(correctionWindow);
      final remainingMinutes = expiresAt.difference(resolvedNow).inMinutes;
      return ExpenseEditPolicyResult(
        capability: ExpenseEditCapability.full,
        canDelete: true,
        fullEditExpiresAt: expiresAt,
        message:
            'Full edit available for ${remainingMinutes.clamp(0, 60)} minutes.',
      );
    }

    return const ExpenseEditPolicyResult(
      capability: ExpenseEditCapability.metadataOnly,
      canDelete: false,
      message: 'Only title and note can be changed.',
    );
  }

  static bool hasFinancialChanges(
    ExpenseEntity original,
    ExpenseEntity edited,
  ) {
    return original.amount != edited.amount ||
        original.expenseType != edited.expenseType ||
        original.splitType != edited.splitType ||
        original.accountId != edited.accountId ||
        original.category != edited.category ||
        original.expenseDate != edited.expenseDate ||
        original.groupId != edited.groupId ||
        original.latitude != edited.latitude ||
        original.longitude != edited.longitude ||
        !_sameParticipants(original.participants, edited.participants);
  }

  static bool _sameParticipants(
    List<ExpenseParticipantEntity> a,
    List<ExpenseParticipantEntity> b,
  ) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      final left = a[i];
      final right = b[i];
      if (left.userId != right.userId ||
          left.amount != right.amount ||
          left.isSettled != right.isSettled ||
          left.settledAt != right.settledAt) {
        return false;
      }
    }
    return true;
  }
}
