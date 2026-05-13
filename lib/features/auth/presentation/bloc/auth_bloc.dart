import '../../xcore.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegisterUsecase _registerUsecase;

  final LoginUsecase _loginUsecase;

  final LogoutUsecase _logoutUsecase;

  final ForgotPasswordUsecase _forgotPasswordUsecase;

  final GetCurrentUserUsecase _getCurrentUserUsecase;

  AuthBloc({
    required RegisterUsecase registerUsecase,
    required LoginUsecase loginUsecase,
    required LogoutUsecase logoutUsecase,
    required ForgotPasswordUsecase forgotPasswordUsecase,
    required GetCurrentUserUsecase getCurrentUserUsecase,
  }) : _registerUsecase = registerUsecase,
       _loginUsecase = loginUsecase,
       _logoutUsecase = logoutUsecase,
       _forgotPasswordUsecase = forgotPasswordUsecase,
       _getCurrentUserUsecase = getCurrentUserUsecase,
       super(const AuthInitial()) {
    on<CheckAuthStatusEvent>(_onCheckAuthStatus);

    on<LoginEvent>(_onLogin);

    on<RegisterEvent>(_onRegister);

    on<ForgotPasswordEvent>(_onForgotPassword);

    on<LogoutEvent>(_onLogout);
  }

  Future<void> _onCheckAuthStatus(CheckAuthStatusEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());

    try {
      final user = await _getCurrentUserUsecase();

      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(const AuthUnauthenticated());
      }
    } catch (_) {
      emit(const AuthUnauthenticated());
    }
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());

    try {
      final user = await _loginUsecase(email: event.email, password: event.password);

      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());

    try {
      final user = await _registerUsecase(name: event.name, nickname: event.nickname, email: event.email, password: event.password);

      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onForgotPassword(ForgotPasswordEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());

    try {
      await _forgotPasswordUsecase(email: event.email);

      emit(const AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());

    try {
      await _logoutUsecase();

      emit(const AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
