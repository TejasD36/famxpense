import '../../../auth/data/datasources/local/auth_local_datasource.dart';
import '../../xcore.dart';

part 'account_bloc.freezed.dart';
part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final GetAccountsUsecase _getAccountsUsecase;
  final SaveAccountUsecase _saveAccountUsecase;
  final DeleteAccountUsecase _deleteAccountUsecase;
  final AuthLocalDatasource _authLocalDatasource;

  AccountBloc({
    required GetAccountsUsecase getAccountsUsecase,
    required SaveAccountUsecase saveAccountUsecase,
    required DeleteAccountUsecase deleteAccountUsecase,
    required AuthLocalDatasource authLocalDatasource,
  }) : _getAccountsUsecase = getAccountsUsecase,
       _saveAccountUsecase = saveAccountUsecase,
       _deleteAccountUsecase = deleteAccountUsecase,
       _authLocalDatasource = authLocalDatasource,
       super(const AccountState.initial()) {
    on<_LoadAccounts>(_onLoadAccounts);
    on<_SaveAccount>(_onSaveAccount);
    on<_DeleteAccount>(_onDeleteAccount);
    on<_UpdateBalance>(_onUpdateBalance);
  }

  String? get _userId => _authLocalDatasource.getUserId();

  Future<void> _onLoadAccounts(_LoadAccounts event, Emitter<AccountState> emit) async {
    try {
      emit(const AccountState.loading());
      final userId = _userId;
      if (userId == null) throw Exception('User not logged in');
      final accounts = await _getAccountsUsecase(userId: userId);
      emit(AccountState.loaded(accounts: accounts));
    } catch (e) {
      emit(AccountState.error(message: e.toString()));
    }
  }

  Future<void> _onSaveAccount(_SaveAccount event, Emitter<AccountState> emit) async {
    try {
      await _saveAccountUsecase(event.account);
      add(const AccountEvent.loadAccounts());
    } catch (e) {
      emit(AccountState.error(message: e.toString()));
    }
  }

  Future<void> _onDeleteAccount(_DeleteAccount event, Emitter<AccountState> emit) async {
    try {
      await _deleteAccountUsecase(event.accountId);
      add(const AccountEvent.loadAccounts());
    } catch (e) {
      emit(AccountState.error(message: e.toString()));
    }
  }

  Future<void> _onUpdateBalance(_UpdateBalance event, Emitter<AccountState> emit) async {
    try {
      final currentState = state;
      final accounts = currentState is _Loaded ? currentState.accounts : <AccountEntity>[];
      final updated = accounts.map((a) {
        if (a.id == event.accountId) {
          return a.copyWith(currentBalance: event.newBalance, updatedAt: DateTime.now().toUtc());
        }
        return a;
      }).toList();
      emit(AccountState.loaded(accounts: updated));
    } catch (e) {
      emit(AccountState.error(message: e.toString()));
    }
  }
}
