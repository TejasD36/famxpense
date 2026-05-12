import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_event.freezed.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.checkAuthStatus() = AuthCheckAuthStatus;

  const factory AuthEvent.login({required String email, required String password}) = AuthLogin;

  const factory AuthEvent.logout() = AuthLogout;
}
