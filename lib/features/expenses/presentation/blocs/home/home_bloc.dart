import '../../../xcore.dart';

part 'home_bloc.freezed.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetCurrentMonthExpensesUsecase _getExpensesUsecase;

  HomeBloc({required GetCurrentMonthExpensesUsecase getExpensesUsecase})
    : _getExpensesUsecase = getExpensesUsecase,
      super(const HomeState.initial()) {
    on<LoadDashboardEvent>(_onLoadDashboard);
  }

  Future<void> _onLoadDashboard(LoadDashboardEvent event, Emitter<HomeState> emit) async {
    emit(const HomeState.loading());

    try {
      final expenses = await _getExpensesUsecase();

      if (expenses.isEmpty) {
        emit(const HomeState.empty());

        return;
      }

      expenses.sort((a, b) => b.expenseDate.compareTo(a.expenseDate));

      final totalSpend = expenses.fold<double>(0, (summation, expense) => summation + expense.amount);

      final personalSpend = expenses
          .where((e) => e.expenseType == ExpenseType.personal)
          .fold<double>(0, (summation, expense) => summation + expense.amount);

      final sharedSpend = expenses
          .where((e) => e.expenseType == ExpenseType.shared)
          .fold<double>(0, (summation, expense) => summation + expense.amount);

      final pendingSyncCount = expenses.where((e) => e.syncStatus == SyncStatus.pending).length;

      emit(
        HomeState.loaded(
          totalSpend: totalSpend,
          personalSpend: personalSpend,
          sharedSpend: sharedSpend,
          pendingSyncCount: pendingSyncCount,
          recentExpenses: expenses.take(5).toList(),
        ),
      );
    } catch (e) {
      emit(HomeState.error(e.toString()));
    }
  }
}
