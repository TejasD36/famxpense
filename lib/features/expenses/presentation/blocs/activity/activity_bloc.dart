import '../../../../account/data/datasources/account_local_datasource.dart';
import '../../../../auth/data/datasources/local/auth_local_datasource.dart';
import '../../../../settlement/data/datasources/settlement_local_datasource.dart';
import '../../../xcore.dart';

part 'activity_bloc.freezed.dart';
part 'activity_event.dart';
part 'activity_state.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  final GetCurrentMonthExpensesUsecase _getExpensesUsecase;
  final SettlementLocalDatasource _settlementLocal;

  ActivityBloc({
    required GetCurrentMonthExpensesUsecase getExpensesUsecase,
    required SettlementLocalDatasource settlementLocal,
  }) : _getExpensesUsecase = getExpensesUsecase,
       _settlementLocal = settlementLocal,
       super(const ActivityState.initial()) {
    on<LoadExpensesEvent>(_onLoadExpenses);
  }

  Future<void> _onLoadExpenses(LoadExpensesEvent event, Emitter<ActivityState> emit) async {
    emit(const ActivityState.loading());

    try {
      final userId = sl<AuthLocalDatasource>().getUserId() ?? '';
      final expenses = await _getExpensesUsecase();
      final settlements = await _settlementLocal.getSettlements();

      /// Only show settlements involving the current user
      final userSettlements = settlements.where((s) => s.fromUserId == userId || s.toUserId == userId);

      String? depositAccountName;
      final defaultAccountId = await AppSettings.getDefaultAccountId(userId: userId);
      if (defaultAccountId != null) {
        final dtos = await sl<AccountLocalDatasource>().getAccounts();
        depositAccountName = dtos.where((a) => a.id == defaultAccountId).firstOrNull?.accountName;
      }

      final items = <ActivityItem>[
        for (final e in expenses) ExpenseItem(e),
        for (final s in userSettlements) SettlementItem(s.toEntity(), depositAccountName: depositAccountName),
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
