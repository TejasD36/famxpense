import '../../xcore.dart';

part 'activity_bloc.freezed.dart';
part 'activity_event.dart';
part 'activity_state.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  final GetCurrentMonthExpensesUsecase _getExpensesUsecase;

  ActivityBloc({required GetCurrentMonthExpensesUsecase getExpensesUsecase})
    : _getExpensesUsecase = getExpensesUsecase,
      super(const ActivityState.initial()) {
    on<LoadExpensesEvent>(_onLoadExpenses);
  }

  Future<void> _onLoadExpenses(LoadExpensesEvent event, Emitter<ActivityState> emit) async {
    emit(const ActivityState.loading());

    try {
      final expenses = await _getExpensesUsecase();

      if (expenses.isEmpty) {
        emit(const ActivityState.empty());

        return;
      }

      expenses.sort((a, b) => b.expenseDate.compareTo(a.expenseDate));

      emit(ActivityState.loaded(expenses));
    } catch (e) {
      emit(ActivityState.error(e.toString()));
    }
  }
}
