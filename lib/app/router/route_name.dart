enum AppRoute {
  splash('/', 'splash'),
  login('/login', 'login'),
  register('/register', 'register'),
  forgotPassword('/forgotPassword', 'forgotPassword'),
  home('/home', 'home'),
  activity('/activity', 'activity'),
  profile('/profile', 'profile'),
  addExpense('/addExpense', 'addExpense'),
  partners('/partners', 'partners'),
  addPartner('/partners/add', 'addPartner'),
  addAccount('/addAccount', 'addAccount'),
  accountDetail('/accountDetail', 'accountDetail'),
  statistics('/statistics', 'statistics'),
  searchActivity('/searchActivity', 'searchActivity'),
  notifications('/notifications', 'notifications'),
  settlements('/settlements', 'settlements'),
  income('/income', 'income');

  final String path;

  final String name;

  const AppRoute(this.path, this.name);
}
