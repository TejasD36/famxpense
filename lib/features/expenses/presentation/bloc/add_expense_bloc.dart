import '../../xcore.dart';

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

      emit(const AddExpenseState.success());
    } catch (e) {
      emit(AddExpenseState.error(e.toString()));
    }
  }
}
