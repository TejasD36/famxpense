enum AppRoute {
  splash('/', 'splash'),

  login('/login', 'login'),

  register('/register', 'register'),

  forgotPassword('/forgotPassword', 'forgotPassword'),

  home('/home', 'home'),

  groups('/groups', 'groups'),

  activity('/activity', 'activity'),

  profile('/profile', 'profile'),

  addExpense('/addExpense', 'addExpense');

  final String path;

  final String name;

  const AppRoute(this.path, this.name);
}
