import '../../xcore.dart';

part 'auth_event.freezed.dart';

@freezed
sealed class AuthEvent with _$AuthEvent {
  const factory AuthEvent.checkAuthStatus() = CheckAuthStatusEvent;

  const factory AuthEvent.login({required String email, required String password}) = LoginEvent;

  const factory AuthEvent.register({required String name, String? nickname, required String email, required String password}) =
      RegisterEvent;

  const factory AuthEvent.forgotPassword({required String email}) = ForgotPasswordEvent;

  const factory AuthEvent.logout() = LogoutEvent;
}
