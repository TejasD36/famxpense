import '../../../xcore.dart';

part 'add_expense_bloc.freezed.dart';
part 'add_expense_event.dart';
part 'add_expense_state.dart';

class AddExpenseBloc extends Bloc<AddExpenseEvent, AddExpenseState> {
  final AddExpenseUsecase _addExpenseUsecase;

  AddExpenseBloc({required AddExpenseUsecase addExpenseUsecase})
    : _addExpenseUsecase = addExpenseUsecase,
      super(const AddExpenseState.initial()) {
    on<SubmitExpenseEvent>(_onSubmit);
  }

  Future<void> _onSubmit(SubmitExpenseEvent event, Emitter<AddExpenseState> emit) async {
    emit(const AddExpenseState.loading());

    try {
      await _addExpenseUsecase(event.expense);

      /// Fire-and-forget notification — must not block success
      if (event.expense.expenseType == ExpenseType.shared) {
        _notifyParticipants(event.expense);
      }

      _syncAfterAdd(event.expense);

      emit(const AddExpenseState.success());
    } catch (e) {
      emit(AddExpenseState.error(e.toString()));
    }
  }

  void _syncAfterAdd(ExpenseEntity expense) {
    sl<SyncService>().syncAll(userId: expense.paidByUserId).then((_) {
      sl<RefreshNotifier>().notifyDataChanged();
    });
  }

  Future<void> _notifyParticipants(ExpenseEntity expense) async {
    try {
      final paidByNickname = () {
        final user = sl<UserLocalDatasource>().getUser(expense.paidByUserId);
        return user?.nickname ?? 'Someone';
      }();

      await sl<NotificationService>().notifyExpenseAdded(
        title: expense.title,
        amount: expense.amount,
        paidByUserId: expense.paidByUserId,
        paidByNickname: paidByNickname,
        participantUserIds: expense.participants.map((p) => p.userId).toList(),
        expenseId: expense.id,
      );
    } catch (e, stackTrace) {
      AppLogger.warning('Notification failed (non-blocking): $e');
      AppLogger.error('Notification error', e, stackTrace);
    }
  }
}
