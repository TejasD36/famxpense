import '../../core.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    AppLogger.debug(
      '${bloc.runtimeType} '
      'Event → $event',
    );

    super.onEvent(bloc, event);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    AppLogger.debug(
      '${bloc.runtimeType} '
      'Change → $change',
    );

    super.onChange(bloc, change);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    AppLogger.error('${bloc.runtimeType} Error', error, stackTrace);

    super.onError(bloc, error, stackTrace);
  }
}
