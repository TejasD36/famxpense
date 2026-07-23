import 'package:bloc_test/bloc_test.dart';
import 'package:famxpense/core/services/notification/notification_service.dart';
import 'package:famxpense/core/services/refresh/refresh_notifier.dart';
import 'package:famxpense/core/services/sync/sync_service.dart';
import 'package:famxpense/features/expenses/domain/usecases/add_expense_usecase.dart';
import 'package:famxpense/features/expenses/presentation/blocs/add_expense/add_expense_bloc.dart';
import 'package:famxpense/shared/data/datasources/local/user_local_datasource.dart';
import 'package:famxpense/shared/domain/entities/expense/expense_entity.dart';
import 'package:famxpense/shared/domain/entities/expense/expense_participant_entity.dart';
import 'package:famxpense/shared/enums/expense_type.dart';
import 'package:famxpense/shared/enums/split_type.dart';
import 'package:famxpense/shared/enums/sync_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../mocks.dart';

final sl = GetIt.instance;

void main() {
  late MockExpenseRepository mockRepository;
  late MockSyncService mockSyncService;
  late MockUserLocalDatasource mockUserDs;
  late MockNotificationService mockNotificationService;

  final now = DateTime(2026, 7, 21, 12, 0, 0).toUtc();

  final personalExpense = ExpenseEntity(
    id: 'exp-1',
    title: 'Coffee',
    amount: 50.0,
    paidByUserId: 'user-a',
    ownerUserId: 'user-a',
    expenseType: ExpenseType.personal,
    splitType: SplitType.equal,
    participants: [
      ExpenseParticipantEntity(userId: 'user-a', amount: 50.0),
    ],
    expenseDate: now,
    createdAt: now,
    updatedAt: now,
    syncStatus: SyncStatus.pending,
  );

  final sharedExpense = ExpenseEntity(
    id: 'exp-2',
    title: 'Lunch',
    amount: 100.0,
    paidByUserId: 'user-a',
    ownerUserId: 'user-a',
    expenseType: ExpenseType.shared,
    splitType: SplitType.equal,
    participants: [
      ExpenseParticipantEntity(userId: 'user-a', amount: 50.0),
      ExpenseParticipantEntity(userId: 'user-b', amount: 50.0),
    ],
    expenseDate: now,
    createdAt: now,
    updatedAt: now,
    syncStatus: SyncStatus.pending,
  );

  setUp(() {
    registerFallbacks();

    mockRepository = MockExpenseRepository();
    mockSyncService = MockSyncService();
    mockUserDs = MockUserLocalDatasource();
    mockNotificationService = MockNotificationService();

    sl.registerSingleton<SyncService>(mockSyncService);
    sl.registerSingleton<RefreshNotifier>(RefreshNotifier());
    sl.registerSingleton<UserLocalDatasource>(mockUserDs);
    sl.registerSingleton<NotificationService>(mockNotificationService);

    when(() => mockSyncService.syncAll(userId: any(named: 'userId')))
        .thenAnswer((_) async => true);
  });

  tearDown(() {
    sl.reset();
  });

  group('AddExpenseBloc', () {
    blocTest<AddExpenseBloc, AddExpenseState>(
      'emits [loading, success] for personal expense',
      build: () {
        when(() => mockRepository.addExpense(any())).thenAnswer((_) async {});
        return AddExpenseBloc(addExpenseUsecase: AddExpenseUsecase(mockRepository));
      },
      act: (bloc) => bloc.add(AddExpenseEvent.submit(personalExpense)),
      expect: () => [
        const AddExpenseState.loading(),
        const AddExpenseState.success(),
      ],
    );

    blocTest<AddExpenseBloc, AddExpenseState>(
      'emits [loading, success] for shared expense with notifications',
      build: () {
        when(() => mockRepository.addExpense(any())).thenAnswer((_) async {});
        when(() => mockUserDs.getUser(any())).thenReturn(null);
        when(() => mockNotificationService.notifyExpenseAdded(
          title: any(named: 'title'),
          amount: any(named: 'amount'),
          paidByUserId: any(named: 'paidByUserId'),
          paidByNickname: any(named: 'paidByNickname'),
          participantUserIds: any(named: 'participantUserIds'),
          expenseId: any(named: 'expenseId'),
        )).thenAnswer((_) async {});
        return AddExpenseBloc(addExpenseUsecase: AddExpenseUsecase(mockRepository));
      },
      act: (bloc) => bloc.add(AddExpenseEvent.submit(sharedExpense)),
      expect: () => [
        const AddExpenseState.loading(),
        const AddExpenseState.success(),
      ],
    );

    blocTest<AddExpenseBloc, AddExpenseState>(
      'emits [loading, error] when repository throws',
      build: () {
        when(() => mockRepository.addExpense(any()))
            .thenThrow(Exception('Network error'));
        return AddExpenseBloc(addExpenseUsecase: AddExpenseUsecase(mockRepository));
      },
      act: (bloc) => bloc.add(AddExpenseEvent.submit(personalExpense)),
      expect: () => [
        const AddExpenseState.loading(),
        const AddExpenseState.error('Exception: Network error'),
      ],
    );

    test('initial state is initial', () {
      when(() => mockRepository.addExpense(any())).thenAnswer((_) async {});
      final bloc = AddExpenseBloc(addExpenseUsecase: AddExpenseUsecase(mockRepository));
      expect(bloc.state, const AddExpenseState.initial());
      bloc.close();
    });
  });
}
