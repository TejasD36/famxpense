import '../../../../account/data/datasources/account_local_datasource.dart';
import '../../../../auth/data/datasources/local/auth_local_datasource.dart';
import '../../../../debt_ledger/domain/usecases/get_debts_usecase.dart';
import '../../../../settlement/data/datasources/settlement_local_datasource.dart';
import '../../../xcore.dart';

part 'home_bloc.freezed.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetCurrentMonthExpensesUsecase _getExpensesUsecase;
  final GetDebtsUsecase _getDebtsUsecase;
  final SettlementLocalDatasource _settlementLocal;

  HomeBloc({
    required GetCurrentMonthExpensesUsecase getExpensesUsecase,
    required GetDebtsUsecase getDebtsUsecase,
    required SettlementLocalDatasource settlementLocal,
  }) : _getExpensesUsecase = getExpensesUsecase,
       _getDebtsUsecase = getDebtsUsecase,
       _settlementLocal = settlementLocal,
       super(const HomeState.initial()) {
    on<LoadDashboardEvent>(_onLoadDashboard);
  }

  Future<void> _onLoadDashboard(
    LoadDashboardEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeState.loading());

    try {
      final expenses = await _getExpensesUsecase();
      final userId = sl<AuthLocalDatasource>().getUserId();
      final debts = userId != null
          ? await _getDebtsUsecase(userId: userId)
          : <DebtLedgerEntity>[];
      final accountDtos = await sl<AccountLocalDatasource>().getAccounts();
      final accountNames = {for (final a in accountDtos) a.id: a.accountName};

      /// Load pending settlements
      final allSettlements = await _settlementLocal.getSettlements();
      final incomingPending = allSettlements
          .where(
            (s) => s.toUserId == userId && s.status == SettlementStatus.pending,
          )
          .map((d) => d.toEntity())
          .toList();
      final outgoingPending = allSettlements
          .where(
            (s) =>
                s.fromUserId == userId && s.status == SettlementStatus.pending,
          )
          .map((d) => d.toEntity())
          .toList();

      expenses.sort((a, b) => b.expenseDate.compareTo(a.expenseDate));

      double userShare(ExpenseEntity expense) {
        if (expense.expenseType == ExpenseType.personal) return expense.amount;
        final p = expense.participants
            .where((p) => p.userId == userId)
            .firstOrNull;
        return p?.amount ?? 0;
      }

      double sumShare(Iterable<ExpenseEntity> exps) =>
          exps.fold<double>(0, (s, e) => s + userShare(e));

      final totalSpend = sumShare(expenses);
      final personalSpend = sumShare(
        expenses.where((e) => e.expenseType == ExpenseType.personal),
      );
      final sharedSpend = sumShare(
        expenses.where((e) => e.expenseType == ExpenseType.shared),
      );

      final pendingSyncCount = userId == null
          ? 0
          : (await sl<ReconciliationService>().load(
              userId: userId,
            )).counts.total;

      emit(
        HomeState.loaded(
          totalSpend: totalSpend,
          personalSpend: personalSpend,
          sharedSpend: sharedSpend,
          pendingSyncCount: pendingSyncCount,
          recentExpenses: expenses.take(5).toList(),
          debts: debts,
          accountNames: accountNames,
          incomingPendingSettlements: incomingPending,
          outgoingPendingSettlements: outgoingPending,
        ),
      );
    } catch (e) {
      emit(HomeState.error(e.toString()));
    }
  }
}
