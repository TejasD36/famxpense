import 'package:famxpense/core/services/reporting/reporting_ledger_service.dart';
import 'package:famxpense/features/account/data/datasources/account_local_datasource.dart';
import 'package:famxpense/features/account/data/datasources/manual_deposit_local_datasource.dart';
import 'package:famxpense/features/expenses/data/datasources/local/expense_local_datasource.dart';
import 'package:famxpense/features/income/data/datasources/income_local_datasource.dart';
import 'package:famxpense/features/savings/data/datasources/transfer_local_datasource.dart';
import 'package:famxpense/features/settlement/data/datasources/settlement_local_datasource.dart';
import 'package:famxpense/shared/data/transformers/dtos/account/account_dto.dart';
import 'package:famxpense/shared/data/transformers/dtos/account/manual_deposit_dto.dart';
import 'package:famxpense/shared/data/transformers/dtos/expense/expense_dto.dart';
import 'package:famxpense/shared/data/transformers/dtos/expense/expense_participant_dto.dart';
import 'package:famxpense/shared/data/transformers/dtos/income/income_dto.dart';
import 'package:famxpense/shared/data/transformers/dtos/settlement/settlement_dto.dart';
import 'package:famxpense/shared/data/transformers/dtos/transfer/transfer_dto.dart';
import 'package:famxpense/shared/enums/account_type.dart';
import 'package:famxpense/shared/enums/expense_type.dart';
import 'package:famxpense/shared/enums/income_source.dart';
import 'package:famxpense/shared/enums/settlement_status.dart';
import 'package:famxpense/shared/enums/split_type.dart';
import 'package:famxpense/shared/enums/sync_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _ExpenseLocal extends Mock implements ExpenseLocalDatasource {}

class _IncomeLocal extends Mock implements IncomeLocalDatasource {}

class _DepositLocal extends Mock implements ManualDepositLocalDatasource {}

class _SettlementLocal extends Mock implements SettlementLocalDatasource {}

class _TransferLocal extends Mock implements TransferLocalDatasource {}

class _AccountLocal extends Mock implements AccountLocalDatasource {}

void main() {
  late _ExpenseLocal expenses;
  late _IncomeLocal incomes;
  late _DepositLocal deposits;
  late _SettlementLocal settlements;
  late _TransferLocal transfers;
  late _AccountLocal accounts;
  late ReportingLedgerService service;

  final date = DateTime(2026, 7, 10, 12);

  setUp(() {
    expenses = _ExpenseLocal();
    incomes = _IncomeLocal();
    deposits = _DepositLocal();
    settlements = _SettlementLocal();
    transfers = _TransferLocal();
    accounts = _AccountLocal();
    service = ReportingLedgerService(
      expenses: expenses,
      incomes: incomes,
      deposits: deposits,
      settlements: settlements,
      transfers: transfers,
      accounts: accounts,
    );
  });

  test(
    'builds one ledger with shared shares, transfers, settlements, and audits',
    () async {
      when(accounts.getAccounts).thenAnswer(
        (_) async => [
          AccountDto(
            id: 'checking',
            userId: 'user-a',
            accountName: 'Checking',
            accountType: AccountType.bank,
            currentBalance: 1000,
            createdAt: date,
            updatedAt: date,
          ),
          AccountDto(
            id: 'savings',
            userId: 'user-a',
            accountName: 'Savings',
            accountType: AccountType.bank,
            currentBalance: 500,
            createdAt: date,
            updatedAt: date,
          ),
        ],
      );
      when(() => expenses.getExpenses(ownerUserId: 'user-a')).thenAnswer(
        (_) async => [
          ExpenseDto(
            id: 'shared-expense',
            title: 'Dinner',
            amount: 300,
            paidByUserId: 'user-a',
            expenseType: ExpenseType.shared,
            splitType: SplitType.manual,
            participants: const [
              ExpenseParticipantDto(userId: 'user-a', amount: 120),
              ExpenseParticipantDto(userId: 'user-b', amount: 180),
            ],
            accountId: 'checking',
            expenseDate: date,
            createdAt: date,
            updatedAt: date,
            syncStatus: SyncStatus.synced,
            ownerUserId: 'user-a',
          ),
        ],
      );
      when(incomes.fetchAll).thenAnswer(
        (_) async => [
          IncomeDto(
            id: 'income',
            userId: 'user-a',
            accountId: 'checking',
            amount: 1000,
            source: IncomeSource.salary,
            description: 'Salary',
            createdAt: date,
            updatedAt: date,
            syncStatus: SyncStatus.synced,
          ),
        ],
      );
      when(deposits.fetchAll).thenAnswer(
        (_) async => [
          ManualDepositDto(
            id: 'deposit',
            userId: 'user-a',
            accountId: 'checking',
            amount: 200,
            description: 'Cash',
            createdAt: date,
          ),
          ManualDepositDto(
            id: 'correction',
            userId: 'user-a',
            accountId: 'checking',
            amount: 50,
            description: 'Fix opening entry',
            createdAt: date,
            isBalanceEdit: true,
            previousBalance: 950,
            newBalance: 1000,
          ),
        ],
      );
      when(settlements.getSettlements).thenAnswer(
        (_) async => [
          SettlementDto(
            id: 'settlement-in',
            fromUserId: 'user-b',
            toUserId: 'user-a',
            amount: 75,
            status: SettlementStatus.confirmed,
            createdAt: DateTime(2026, 7, 1),
            resolvedAt: date,
            toAccountId: 'checking',
          ),
          SettlementDto(
            id: 'settlement-out',
            fromUserId: 'user-a',
            toUserId: 'user-b',
            amount: 40,
            status: SettlementStatus.confirmed,
            createdAt: date,
            fromAccountId: 'checking',
          ),
        ],
      );
      when(transfers.fetchAll).thenAnswer(
        (_) async => [
          TransferDto(
            id: 'transfer',
            fromAccountId: 'checking',
            toAccountId: 'savings',
            fromUserId: 'user-a',
            toUserId: 'user-a',
            amount: 300,
            description: 'Save',
            createdAt: date,
            updatedAt: date,
            syncStatus: SyncStatus.synced,
          ),
        ],
      );

      final ledger = await service.load(
        userId: 'user-a',
        period: ReportingPeriod.month(DateTime(2026, 7)),
      );

      expect(ledger.rows, hasLength(8));
      expect(ledger.totalSpent, 460);
      expect(ledger.totalDeposited, 1575);
      expect(ledger.auditCount, 1);
      expect(
        ledger.rows
            .where((row) => row.type == ReportingLedgerRowType.expense)
            .single
            .amount,
        120,
      );
      expect(
        ledger.rows
            .where(
              (row) => row.type == ReportingLedgerRowType.balanceCorrection,
            )
            .single
            .isAuditOnly,
        isTrue,
      );
      expect(ledger.accountSummaries['checking']!.outflowTotal, 460);
      expect(ledger.accountSummaries['checking']!.inflowTotal, 1275);
      expect(ledger.accountSummaries['savings']!.inflowTotal, 300);
    },
  );
}
