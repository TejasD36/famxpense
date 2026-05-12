import '../../../core.dart';

part 'settlement_entity.freezed.dart';
part 'settlement_entity.g.dart';

@freezed
sealed class SettlementEntity with _$SettlementEntity {
  const factory SettlementEntity({
    required String id,
    required String fromUserId,
    required String toUserId,
    required double amount,
    required SettlementStatus status,
    required DateTime createdAt,
    DateTime? confirmedAt,
    List<String>? relatedExpenseIds,
  }) = _SettlementEntity;

  factory SettlementEntity.fromJson(Map<String, dynamic> json) => _$SettlementEntityFromJson(json);
}
