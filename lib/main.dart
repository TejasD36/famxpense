import 'core.dart';
import 'flavors.dart';

Future<void> main() async {
  F.appFlavor = Flavor.values.firstWhere((f) => f.name == const String.fromEnvironment('FLAVOR', defaultValue: 'prod'));

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: F.firebaseOptions);
  await HiveInitializer.initialize();
  Bloc.observer = SimpleBlocObserver();
  await initDependencies();
  runApp(const App());
}
