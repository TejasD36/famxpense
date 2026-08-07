import 'package:famxpense/core/di/injection.dart';
import 'package:famxpense/features/account/data/datasources/account_local_datasource.dart';
import 'package:famxpense/features/account/data/datasources/manual_deposit_local_datasource.dart';
import 'package:famxpense/features/auth/data/datasources/local/auth_local_datasource.dart';
import 'package:famxpense/features/expenses/data/datasources/local/expense_local_datasource.dart';
import 'package:famxpense/features/income/data/datasources/income_local_datasource.dart';
import 'package:famxpense/features/settlement/data/datasources/settlement_local_datasource.dart';
import 'package:famxpense/features/statistics/presentation/blocs/statistics_bloc.dart';
import 'package:famxpense/shared/data/transformers/dtos/account/manual_deposit_dto.dart';
import 'package:famxpense/shared/data/transformers/dtos/expense/expense_dto.dart';
import 'package:famxpense/shared/data/transformers/dtos/expense/expense_participant_dto.dart';
import 'package:famxpense/shared/data/transformers/dtos/income/income_dto.dart';
import 'package:famxpense/shared/data/transformers/dtos/settlement/settlement_dto.dart';
import 'package:famxpense/shared/enums/expense_type.dart';
import 'package:famxpense/shared/enums/income_source.dart';
import 'package:famxpense/shared/enums/settlement_status.dart';
import 'package:famxpense/shared/enums/split_type.dart';
import 'package:famxpense/shared/enums/sync_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _ExpenseLocal extends Mock implements ExpenseLocalDatasource {}

class _AccountLocal extends Mock implements AccountLocalDatasource {}

class _DepositLocal extends Mock implements ManualDepositLocalDatasource {}

class _SettlementLocal extends Mock implements SettlementLocalDatasource {}

class _IncomeLocal extends Mock implements IncomeLocalDatasource {}

class _AuthLocal extends Mock implements AuthLocalDatasource {}

void main() {
  late _ExpenseLocal expenses;
  late _DepositLocal deposits;
  late _SettlementLocal settlements;
  late _IncomeLocal incomes;

  ExpenseDto expense(String id, DateTime date, double share) => ExpenseDto(
    id: id,
    title: id,
    amount: share,
    paidByUserId: 'user-a',
    ownerUserId: 'user-a',
    expenseType: ExpenseType.personal,
    splitType: SplitType.equal,
    participants: [ExpenseParticipantDto(userId: 'user-a', amount: share)],
    expenseDate: date,
    createdAt: date,
    updatedAt: date,
    syncStatus: SyncStatus.synced,
  );

  setUp(() async {
    await sl.reset();
    expenses = _ExpenseLocal();
    deposits = _DepositLocal();
    settlements = _SettlementLocal();
    incomes = _IncomeLocal();
    final accounts = _AccountLocal();
    final auth = _AuthLocal();
    when(auth.getUserId).thenReturn('user-a');
    when(accounts.getAccounts).thenAnswer((_) async => []);
    when(incomes.fetchAll).thenAnswer((_) async => []);
    sl.registerSingleton<AuthLocalDatasource>(auth);
    sl.registerSingleton<ExpenseLocalDatasource>(expenses);
    sl.registerSingleton<AccountLocalDatasource>(accounts);
    sl.registerSingleton<ManualDepositLocalDatasource>(deposits);
    sl.registerSingleton<SettlementLocalDatasource>(settlements);
    sl.registerSingleton<IncomeLocalDatasource>(incomes);
  });

  test(
    'custom range drives summary totals and includes the entire end date',
    () async {
      when(() => expenses.getExpenses(ownerUserId: 'user-a')).thenAnswer(
        (_) async => [
          expense('before', DateTime(2026, 6, 30, 23, 59), 999),
          expense('start', DateTime(2026, 7, 1), 40),
          expense('end', DateTime(2026, 8, 1, 23, 59), 60),
          expense('after', DateTime(2026, 8, 2), 999),
        ],
      );
      when(deposits.fetchAll).thenAnswer(
        (_) async => [
          ManualDepositDto(
            id: 'deposit',
            accountId: 'account',
            amount: 75,
            description: 'Deposit',
            createdAt: DateTime(2026, 7, 20),
          ),
        ],
      );
      when(incomes.fetchAll).thenAnswer(
        (_) async => [
          IncomeDto(
            id: 'income',
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
            id: 'income-outside-range',
            userId: 'user-a',
            accountId: 'account',
            amount: 999,
            source: IncomeSource.other,
            description: 'Out of range',
            createdAt: DateTime(2026, 8, 2),
            updatedAt: DateTime(2026, 8, 2),
            syncStatus: SyncStatus.synced,
          ),
        ],
      );
      when(settlements.getSettlements).thenAnswer(
        (_) async => [
          SettlementDto(
            id: 'incoming',
            fromUserId: 'user-b',
            toUserId: 'user-a',
            amount: 25,
            status: SettlementStatus.confirmed,
            createdAt: DateTime(2026, 8, 1, 22),
          ),
          SettlementDto(
            id: 'pending',
            fromUserId: 'user-b',
            toUserId: 'user-a',
            amount: 500,
            status: SettlementStatus.pending,
            createdAt: DateTime(2026, 7, 20),
          ),
        ],
      );

      final bloc = StatisticsBloc();
      bloc.add(
        StatisticsEvent.load(
          month: DateTime(2026, 7),
          rangeStart: DateTime(2026, 7, 1),
          rangeEnd: DateTime(2026, 8, 1),
        ),
      );

      final state =
          await bloc.stream.firstWhere((state) => state is StatisticsLoaded)
              as StatisticsLoaded;
      expect(state.totalSpent, 100);
      expect(state.totalDeposited, 125);
      expect(state.expenseCount, 2);
      expect(state.depositCount, 3);
      expect(
        state.transactions.map((item) => item.id),
        containsAll(['start', 'end', 'deposit', 'income', 'incoming']),
      );
      await bloc.close();
    },
  );
}
