class AuthUserModel {
  final String userId;
  final String email;
  final String role;

  const AuthUserModel({required this.userId, required this.email, required this.role});

  bool get isAdmin => role == 'admin';
  bool get isUser => role == 'user';
}
