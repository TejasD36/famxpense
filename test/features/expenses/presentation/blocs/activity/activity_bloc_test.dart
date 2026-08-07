import 'dart:io';

import 'package:famxpense/core/di/injection.dart';
import 'package:famxpense/features/account/data/datasources/account_local_datasource.dart';
import 'package:famxpense/features/auth/data/datasources/local/auth_local_datasource.dart';
import 'package:famxpense/features/expenses/domain/repositories/expense_repository.dart';
import 'package:famxpense/features/expenses/presentation/blocs/activity/activity_bloc.dart';
import 'package:famxpense/features/expenses/presentation/blocs/activity/activity_item.dart';
import 'package:famxpense/features/income/data/datasources/income_local_datasource.dart';
import 'package:famxpense/features/settlement/data/datasources/settlement_local_datasource.dart';
import 'package:famxpense/shared/data/transformers/dtos/income/income_dto.dart';
import 'package:famxpense/shared/data/transformers/dtos/settlement/settlement_dto.dart';
import 'package:famxpense/shared/domain/entities/expense/expense_entity.dart';
import 'package:famxpense/shared/domain/entities/expense/expense_participant_entity.dart';
import 'package:famxpense/shared/enums/expense_type.dart';
import 'package:famxpense/shared/enums/income_source.dart';
import 'package:famxpense/shared/enums/settlement_status.dart';
import 'package:famxpense/shared/enums/split_type.dart';
import 'package:famxpense/shared/enums/sync_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';
import 'package:mocktail/mocktail.dart';

class _ExpenseRepository extends Mock implements ExpenseRepository {}

class _SettlementLocal extends Mock implements SettlementLocalDatasource {}

class _AuthLocal extends Mock implements AuthLocalDatasource {}

class _AccountLocal extends Mock implements AccountLocalDatasource {}

class _IncomeLocal extends Mock implements IncomeLocalDatasource {}

void main() {
  late Directory hiveDirectory;
  late _ExpenseRepository expenses;
  late _SettlementLocal settlements;
  late _IncomeLocal incomes;

  ExpenseEntity expense(String id, DateTime date) => ExpenseEntity(
    id: id,
    title: id,
    amount: 100,
    paidByUserId: 'user-a',
    ownerUserId: 'user-a',
    expenseType: ExpenseType.personal,
    splitType: SplitType.equal,
    participants: const [
      ExpenseParticipantEntity(userId: 'user-a', amount: 100),
    ],
    expenseDate: date,
    createdAt: date,
    updatedAt: date,
    syncStatus: SyncStatus.synced,
  );

  setUpAll(() async {
    hiveDirectory = await Directory.systemTemp.createTemp(
      'famxpense_activity_test_',
    );
    Hive.init(hiveDirectory.path);
  });

  setUp(() async {
    await sl.reset();
    expenses = _ExpenseRepository();
    settlements = _SettlementLocal();
    final auth = _AuthLocal();
    final accounts = _AccountLocal();
    incomes = _IncomeLocal();
    when(auth.getUserId).thenReturn('user-a');
    when(accounts.getAccounts).thenAnswer((_) async => []);
    when(incomes.fetchAll).thenAnswer((_) async => []);
    sl.registerSingleton<AuthLocalDatasource>(auth);
    sl.registerSingleton<AccountLocalDatasource>(accounts);
    sl.registerSingleton<IncomeLocalDatasource>(incomes);
  });

  tearDownAll(() async {
    await Hive.close();
    await hiveDirectory.delete(recursive: true);
  });

  test(
    'date range is inclusive and filters expenses and settlements',
    () async {
      when(expenses.getExpenses).thenAnswer(
        (_) async => [
          expense('before', DateTime(2026, 6, 30, 23, 59)),
          expense('start', DateTime(2026, 7, 1)),
          expense('end', DateTime(2026, 8, 1, 23, 59)),
          expense('after', DateTime(2026, 8, 2)),
        ],
      );
      when(settlements.getSettlements).thenAnswer(
        (_) async => [
          SettlementDto(
            id: 'settled-on-end',
            fromUserId: 'user-a',
            toUserId: 'user-b',
            amount: 50,
            status: SettlementStatus.confirmed,
            createdAt: DateTime(2026, 8, 1, 20),
          ),
          SettlementDto(
            id: 'pending',
            fromUserId: 'user-a',
            toUserId: 'user-b',
            amount: 50,
            status: SettlementStatus.pending,
            createdAt: DateTime(2026, 7, 15),
          ),
        ],
      );

      final bloc = ActivityBloc(
        expenseRepository: expenses,
        settlementLocal: settlements,
      );
      bloc.add(
        ActivityEvent.loadExpenses(
          rangeStart: DateTime(2026, 7, 1),
          rangeEnd: DateTime(2026, 8, 1),
        ),
      );

      final loaded =
          await bloc.stream.firstWhere((state) => state is ActivityLoaded)
              as ActivityLoaded;
      expect(
        loaded.items.map((item) => item.id),
        containsAllInOrder(['end', 'settled-on-end', 'start']),
      );
      expect(loaded.items.whereType<SettlementItem>(), hasLength(1));
      await bloc.close();
    },
  );

  test('month filter excludes transactions from adjacent months', () async {
    when(expenses.getExpenses).thenAnswer(
      (_) async => [
        expense('july', DateTime(2026, 7, 31)),
        expense('august', DateTime(2026, 8, 1)),
      ],
    );
    when(settlements.getSettlements).thenAnswer((_) async => []);

    final bloc = ActivityBloc(
      expenseRepository: expenses,
      settlementLocal: settlements,
    );
    bloc.add(ActivityEvent.loadExpenses(month: DateTime(2026, 8)));

    final loaded =
        await bloc.stream.firstWhere((state) => state is ActivityLoaded)
            as ActivityLoaded;
    expect(loaded.items.single.id, 'august');
    await bloc.close();
  });

  test('includes incomes for the selected month as IncomeItems', () async {
    when(expenses.getExpenses).thenAnswer((_) async => []);
    when(settlements.getSettlements).thenAnswer((_) async => []);
    when(incomes.fetchAll).thenAnswer(
      (_) async => [
        IncomeDto(
          id: 'income-july',
          userId: 'user-a',
          accountId: 'account',
          amount: 50,
          source: IncomeSource.salary,
          description: 'Salary',
          createdAt: DateTime(2026, 7, 25),
          updatedAt: DateTime(2026, 7, 25),
          syncStatus: SyncStatus.synced,
        ),
        IncomeDto(
          id: 'income-august',
          userId: 'user-a',
          accountId: 'account',
          amount: 20,
          source: IncomeSource.other,
          description: 'Gift',
          createdAt: DateTime(2026, 8, 1),
          updatedAt: DateTime(2026, 8, 1),
          syncStatus: SyncStatus.synced,
        ),
      ],
    );

    final bloc = ActivityBloc(
      expenseRepository: expenses,
      settlementLocal: settlements,
    );
    bloc.add(ActivityEvent.loadExpenses(month: DateTime(2026, 8)));

    final loaded =
        await bloc.stream.firstWhere((state) => state is ActivityLoaded)
            as ActivityLoaded;
    expect(loaded.items, hasLength(1));
    final item = loaded.items.single as IncomeItem;
    expect(item.id, 'income-august');
    expect(item.amount, 20);
    await bloc.close();
  });
}
