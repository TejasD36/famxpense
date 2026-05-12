enum AppRoute {
  splash('/', 'splash'),
  login('/login', 'login'),
  register('/register', 'register'),
  forgotPassword('/forgotPassword', 'forgotPassword'),
  dashboard('/dashboard', 'dashboard'),
  expenses('/expenses', 'expenses'),
  accounts('/accounts', 'accounts'),
  groups('/groups', 'groups'),
  profile('/profile', 'profile');

  final String path;
  final String name;

  const AppRoute(this.path, this.name);
}
