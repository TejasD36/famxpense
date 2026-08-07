import '../../../../account/data/datasources/account_local_datasource.dart';
import '../../../../auth/data/datasources/local/auth_local_datasource.dart';
import '../../../../income/data/datasources/income_local_datasource.dart';
import '../../../../settlement/data/datasources/settlement_local_datasource.dart';
import '../../../xcore.dart';

part 'activity_bloc.freezed.dart';
part 'activity_event.dart';
part 'activity_state.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  final ExpenseRepository _expenseRepository;
  final SettlementLocalDatasource _settlementLocal;

  ActivityBloc({
    required ExpenseRepository expenseRepository,
    required SettlementLocalDatasource settlementLocal,
  }) : _expenseRepository = expenseRepository,
       _settlementLocal = settlementLocal,
       super(const ActivityState.initial()) {
    on<LoadExpensesEvent>(_onLoadExpenses);
  }

  Future<void> _onLoadExpenses(
    LoadExpensesEvent event,
    Emitter<ActivityState> emit,
  ) async {
    emit(const ActivityState.loading());

    try {
      final userId = sl<AuthLocalDatasource>().getUserId() ?? '';
      final allExpenses = await _expenseRepository.getExpenses();

      var expenses = allExpenses;
      if (event.rangeStart != null && event.rangeEnd != null) {
        final endExclusive = DateTime(
          event.rangeEnd!.year,
          event.rangeEnd!.month,
          event.rangeEnd!.day + 1,
        );
        expenses = allExpenses
            .where(
              (e) =>
                  !e.expenseDate.isBefore(event.rangeStart!) &&
                  e.expenseDate.isBefore(endExclusive),
            )
            .toList();
      } else if (event.month != null) {
        expenses = allExpenses
            .where(
              (e) =>
                  e.expenseDate.year == event.month!.year &&
                  e.expenseDate.month == event.month!.month,
            )
            .toList();
      }

      final settlements = await _settlementLocal.getSettlements();

      /// Only show confirmed settlements involving the current user
      var userSettlements = settlements.where(
        (s) =>
            (s.fromUserId == userId || s.toUserId == userId) &&
            s.status == SettlementStatus.confirmed,
      );
      if (event.rangeStart != null && event.rangeEnd != null) {
        final endExclusive = DateTime(
          event.rangeEnd!.year,
          event.rangeEnd!.month,
          event.rangeEnd!.day + 1,
        );
        userSettlements = userSettlements.where(
          (s) =>
              !s.createdAt.isBefore(event.rangeStart!) &&
              s.createdAt.isBefore(endExclusive),
        );
      } else if (event.month != null) {
        userSettlements = userSettlements.where(
          (s) =>
              s.createdAt.year == event.month!.year &&
              s.createdAt.month == event.month!.month,
        );
      }

      final allIncomes = (await sl<IncomeLocalDatasource>().fetchAll())
          .where((i) => i.userId == userId && !i.isDeleted)
          .map((d) => d.toEntity())
          .toList();

      var incomes = allIncomes;
      if (event.rangeStart != null && event.rangeEnd != null) {
        final endExclusive = DateTime(
          event.rangeEnd!.year,
          event.rangeEnd!.month,
          event.rangeEnd!.day + 1,
        );
        incomes = allIncomes
            .where(
              (i) =>
                  !i.createdAt.isBefore(event.rangeStart!) &&
                  i.createdAt.isBefore(endExclusive),
            )
            .toList();
      } else if (event.month != null) {
        incomes = allIncomes
            .where(
              (i) =>
                  i.createdAt.year == event.month!.year &&
                  i.createdAt.month == event.month!.month,
            )
            .toList();
      }

      String? depositAccountName;
      final defaultAccountId = await AppSettings.getDefaultAccountId(
        userId: userId,
      );
      final accountDtos = await sl<AccountLocalDatasource>().getAccounts();
      if (defaultAccountId != null) {
        depositAccountName = accountDtos
            .where((a) => a.id == defaultAccountId)
            .firstOrNull
            ?.accountName;
      }
      final accountNames = {
        for (final a in accountDtos) a.id: a.accountName,
      };

      final items = <ActivityItem>[
        for (final e in expenses) ExpenseItem(e),
        for (final s in userSettlements)
          SettlementItem(s.toEntity(), depositAccountName: depositAccountName),
        for (final i in incomes)
          IncomeItem(i, accountName: accountNames[i.accountId]),
      ];

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
