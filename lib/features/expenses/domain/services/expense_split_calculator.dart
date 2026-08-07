class ExpenseSplitCalculator {
  const ExpenseSplitCalculator._();

  static Map<String, double> equal({
    required double totalAmount,
    required List<String> participantIds,
  }) {
    if (!totalAmount.isFinite || totalAmount < 0) {
      throw ArgumentError.value(
        totalAmount,
        'totalAmount',
        'Total must be finite and non-negative',
      );
    }
    if (participantIds.isEmpty) {
      throw ArgumentError.value(
        participantIds,
        'participantIds',
        'At least one participant is required',
      );
    }
    if (participantIds.toSet().length != participantIds.length) {
      throw ArgumentError.value(
        participantIds,
        'participantIds',
        'Participant IDs must be unique',
      );
    }

    final totalPaise = (totalAmount * 100).round();
    final basePaise = totalPaise ~/ participantIds.length;
    var remainder = totalPaise.remainder(participantIds.length);
    final result = <String, double>{};

    for (final participantId in participantIds) {
      final paise = basePaise + (remainder > 0 ? 1 : 0);
      if (remainder > 0) remainder--;
      result[participantId] = paise / 100;
    }
    return result;
  }
}
