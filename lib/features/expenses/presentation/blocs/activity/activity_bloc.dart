import '../../../../auth/data/datasources/local/auth_local_datasource.dart';
import '../../../../settlement/data/datasources/settlement_local_datasource.dart';
import '../../../xcore.dart';

part 'activity_bloc.freezed.dart';
part 'activity_event.dart';
part 'activity_state.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  ActivityBloc({
    required ExpenseRepository expenseRepository,
    required SettlementLocalDatasource settlementLocal,
  }) : super(const ActivityState.initial()) {
    on<LoadExpensesEvent>(_onLoadExpenses);
  }

  Future<void> _onLoadExpenses(
    LoadExpensesEvent event,
    Emitter<ActivityState> emit,
  ) async {
    emit(const ActivityState.loading());

    try {
      final userId = sl<AuthLocalDatasource>().getUserId();
      if (userId == null) {
        emit(const ActivityState.error('User not found'));
        return;
      }
      final hasRange = event.rangeStart != null && event.rangeEnd != null;
      final period = hasRange
          ? ReportingPeriod.range(event.rangeStart!, event.rangeEnd!)
          : ReportingPeriod.month(event.month ?? DateTime.now());
      final ledger = await sl<ReportingLedgerService>().load(
        userId: userId,
        period: period,
      );
      final accountNames = {
        for (final account in ledger.accounts) account.id: account.accountName,
      };

      final items = ledger.rows.map((row) {
        switch (row.type) {
          case ReportingLedgerRowType.expense:
            return ExpenseItem(row.expense!.toEntity());
          case ReportingLedgerRowType.income:
            return IncomeItem(
              row.income!.toEntity(),
              accountName: accountNames[row.accountId],
            );
          case ReportingLedgerRowType.manualDeposit:
            return ManualDepositItem(
              row.manualDeposit!,
              accountName: accountNames[row.accountId],
            );
          case ReportingLedgerRowType.balanceCorrection:
            return BalanceCorrectionItem(
              row.manualDeposit!,
              accountName: accountNames[row.accountId],
            );
          case ReportingLedgerRowType.transferIn:
            return TransferActivityItem(
              row.transfer!,
              isIncoming: true,
              accountName: accountNames[row.accountId],
              linkedAccountName: accountNames[row.transferAccountId],
            );
          case ReportingLedgerRowType.transferOut:
            return TransferActivityItem(
              row.transfer!,
              isIncoming: false,
              accountName: accountNames[row.accountId],
              linkedAccountName: accountNames[row.transferAccountId],
            );
          case ReportingLedgerRowType.settlementIn ||
              ReportingLedgerRowType.settlementOut:
            return SettlementItem(
              row.settlement!.toEntity(),
              depositAccountName: accountNames[row.accountId],
            );
        }
      }).toList();

      if (items.isEmpty) {
        emit(const ActivityState.empty());
        return;
      }

      items.sort((a, b) => b.date.compareTo(a.date));

      emit(ActivityState.loaded(items));
    } catch (e) {
      emit(ActivityState.error(e.toString()));
    }
  }
}
