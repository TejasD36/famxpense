import '../../../core.dart';

part 'debt_ledger_entity.freezed.dart';
part 'debt_ledger_entity.g.dart';

@freezed
sealed class DebtLedgerEntity with _$DebtLedgerEntity {
  const factory DebtLedgerEntity({
    required String id,
    required String userA,
    required String userB,
    required double netBalance,
    required DateTime updatedAt,
  }) = _DebtLedgerEntity;

  factory DebtLedgerEntity.fromJson(Map<String, dynamic> json) => _$DebtLedgerEntityFromJson(json);
}
