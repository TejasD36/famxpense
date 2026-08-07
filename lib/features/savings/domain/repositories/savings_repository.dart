import '../../xcore.dart';

abstract interface class SavingsRepository {
  Future<MonthlySavingEntity> computeCurrentMonth(
    String accountId,
    double currentBalance,
    double goalAmount,
  );
  Future<void> finalizeMonth(String accountId, int year, int month);
  Future<List<MonthlySavingEntity>> getAccountHistory(String accountId);
  Future<MonthlySavingEntity?> getSnapshot(
    String accountId,
    int year,
    int month,
  );
  Future<double> getTotalSavedYearToDate(String userId);
  Future<double> getTotalSavedForMonth(String userId, int year, int month);
}
