import 'core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await HiveInitializer.initialize();

  Bloc.observer = SimpleBlocObserver();

  await initDependencies();

  runApp(const App());
}
