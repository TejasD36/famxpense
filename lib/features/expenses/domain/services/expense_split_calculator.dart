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

    final roundedTotal = totalAmount.round();
    if ((totalAmount - roundedTotal).abs() > 0.000001) {
      throw ArgumentError.value(
        totalAmount,
        'totalAmount',
        'Total must be a whole rupee amount',
      );
    }

    final baseRupees = roundedTotal ~/ participantIds.length;
    final remainder = roundedTotal.remainder(participantIds.length);
    final result = <String, double>{};

    for (var i = 0; i < participantIds.length; i++) {
      final participantId = participantIds[i];
      result[participantId] = (baseRupees + (i == 0 ? remainder : 0))
          .toDouble();
    }
    return result;
  }
}
