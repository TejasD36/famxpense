import '../../../../core.dart';
import '../../domain/usecases/check_auth_status_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required CheckAuthStatusUseCase checkAuthStatusUseCase,
    required LoginUseCase loginUseCase,
    required LogoutUseCase logoutUseCase,
  }) : _checkAuthStatusUseCase = checkAuthStatusUseCase,
       _loginUseCase = loginUseCase,
       _logoutUseCase = logoutUseCase,
       super(const AuthState.initial()) {
    on<AuthCheckAuthStatus>(_onCheckAuthStatus);
    on<AuthLogin>(_onLogin);
    on<AuthLogout>(_onLogout);
  }

  final CheckAuthStatusUseCase _checkAuthStatusUseCase;
  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;

  Future<void> _onCheckAuthStatus(AuthCheckAuthStatus event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());

    final user = await _checkAuthStatusUseCase();

    if (user != null) {
      emit(AuthState.authenticated(user));
    } else {
      emit(const AuthState.unauthenticated());
    }
  }

  Future<void> _onLogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());

    final user = await _loginUseCase(email: event.email, password: event.password);

    if (user == null) {
      emit(const AuthState.error('Invalid email or password'));
      emit(const AuthState.unauthenticated());
      return;
    }

    emit(AuthState.authenticated(user));
  }

  Future<void> _onLogout(AuthLogout event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());

    await _logoutUseCase();

    emit(const AuthState.unauthenticated());
  }
}
