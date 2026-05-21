import '../../core.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState()) {
    _loadTheme();
  }

  static const _boxName = 'settings_box';
  static const _themeKey = 'theme_mode';

  Future<void> _loadTheme() async {
    final box = await Hive.openBox(_boxName);

    final value = box.get(_themeKey) as String?;

    switch (value) {
      case 'light':
        emit(state.copyWith(themeMode: ThemeMode.light));
        break;
      case 'dark':
        emit(state.copyWith(themeMode: ThemeMode.dark));
        break;
      default:
        emit(state.copyWith(themeMode: ThemeMode.system));
    }
  }

  Future<void> setTheme(ThemeMode mode) async {
    final box = await Hive.openBox(_boxName);

    final value = switch (mode) {
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
      ThemeMode.system => 'system',
    };

    await box.put(_themeKey, value);

    emit(state.copyWith(themeMode: mode));
  }
}
