import 'package:bloc_test/bloc_test.dart';
import 'package:famxpense/core/services/refresh/refresh_notifier.dart';
import 'package:famxpense/features/auth/data/datasources/local/auth_local_datasource.dart';
import 'package:famxpense/features/notification/presentation/blocs/notification_bloc.dart';
import 'package:famxpense/shared/data/transformers/dtos/notification/notification_dto.dart';
import 'package:famxpense/shared/enums/notification_type.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';

final sl = GetIt.instance;

void main() {
  late MockNotificationLocalDatasource datasource;
  late MockAuthLocalDatasource authDs;
  late NotificationBloc bloc;

  setUp(() {
    datasource = MockNotificationLocalDatasource();
    authDs = MockAuthLocalDatasource();

    sl.registerSingleton<AuthLocalDatasource>(authDs);
    sl.registerSingleton<RefreshNotifier>(RefreshNotifier());

    bloc = NotificationBloc(datasource: datasource);
  });

  tearDown(() {
    bloc.close();
    sl.reset();
  });

  group('NotificationBloc', () {
    final testNotifications = [
      NotificationDto(
        id: 'notif-2',
        userId: 'user-1',
        type: NotificationType.settlementConfirmed,
        title: 'Settlement',
        message: 'Settlement confirmed',
        createdAt: DateTime(2026, 7, 1, 12, 0, 0),
        isRead: true,
      ),
      NotificationDto(
        id: 'notif-1',
        userId: 'user-1',
        type: NotificationType.partnerRequest,
        title: 'Partner Request',
        message: 'Partner request from user',
        createdAt: DateTime(2026, 7, 1, 10, 0, 0),
        isRead: false,
      ),
    ];

    blocTest<NotificationBloc, NotificationState>(
      'emits [loading, loaded] when loading succeeds',
      build: () {
        when(() => authDs.getUserId()).thenReturn('user-1');
        when(() => datasource.getNotifications()).thenAnswer((_) async => testNotifications);
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadNotificationsEvent()),
      expect: () => [
        const NotificationState.loading(),
        NotificationState.loaded(testNotifications),
      ],
    );

    blocTest<NotificationBloc, NotificationState>(
      'emits [loading, error] when loading fails',
      build: () {
        when(() => authDs.getUserId()).thenReturn('user-1');
        when(() => datasource.getNotifications()).thenThrow(Exception('Storage error'));
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadNotificationsEvent()),
      expect: () => [
        const NotificationState.loading(),
        NotificationState.error('Exception: Storage error'),
      ],
    );

    blocTest<NotificationBloc, NotificationState>(
      'marks notification as read and reloads',
      build: () {
        when(() => authDs.getUserId()).thenReturn('user-1');
        when(() => datasource.getNotifications()).thenAnswer((_) async => testNotifications);
        when(() => datasource.markAsRead(any())).thenAnswer((_) async {});
        return bloc;
      },
      act: (bloc) => bloc.add(const MarkNotificationReadEvent(notificationId: 'notif-1')),
      expect: () => [
        const NotificationState.loading(),
        NotificationState.loaded(testNotifications),
      ],
      verify: (_) {
        verify(() => datasource.markAsRead('notif-1')).called(1);
      },
    );

    blocTest<NotificationBloc, NotificationState>(
      'deletes notification and reloads',
      build: () {
        when(() => authDs.getUserId()).thenReturn('user-1');
        when(() => datasource.getNotifications()).thenAnswer((_) async => testNotifications);
        when(() => datasource.deleteNotification(any())).thenAnswer((_) async {});
        return bloc;
      },
      act: (bloc) => bloc.add(const DeleteNotificationEvent(notificationId: 'notif-2')),
      expect: () => [
        const NotificationState.loading(),
        NotificationState.loaded(testNotifications),
      ],
      verify: (_) {
        verify(() => datasource.deleteNotification('notif-2')).called(1);
      },
    );
  });
}
