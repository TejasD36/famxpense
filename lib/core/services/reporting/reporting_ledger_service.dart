import '../../../features/account/data/datasources/account_local_datasource.dart';
import '../../../features/account/data/datasources/manual_deposit_local_datasource.dart';
import '../../../features/expenses/data/datasources/local/expense_local_datasource.dart';
import '../../../features/income/data/datasources/income_local_datasource.dart';
import '../../../features/savings/data/datasources/transfer_local_datasource.dart';
import '../../../features/settlement/data/datasources/settlement_local_datasource.dart';
import '../../../shared/data/transformers/dtos/account/account_dto.dart';
import '../../../shared/data/transformers/dtos/account/manual_deposit_dto.dart';
import '../../../shared/data/transformers/dtos/expense/expense_dto.dart';
import '../../../shared/data/transformers/dtos/income/income_dto.dart';
import '../../../shared/data/transformers/dtos/settlement/settlement_dto.dart';
import '../../../shared/data/transformers/dtos/transfer/transfer_dto.dart';
import '../../../shared/enums/expense_category.dart';
import '../../../shared/enums/expense_type.dart';
import '../../../shared/enums/settlement_status.dart';
import '../../utils/date_period.dart';

enum ReportingLedgerRowType {
  expense,
  income,
  manualDeposit,
  balanceCorrection,
  transferIn,
  transferOut,
  settlementIn,
  settlementOut,
}

class ReportingPeriod {
  final DateTime? month;
  final DateTime? start;
  final DateTime? end;

  const ReportingPeriod.month(DateTime value)
    : month = value,
      start = null,
      end = null;

  const ReportingPeriod.range(DateTime this.start, DateTime this.end)
    : month = null;

  bool contains(DateTime date) {
    if (start != null && end != null) {
      return isInInclusiveRange(date, start!, end!);
    }
    return isInLocalMonth(date, month ?? DateTime.now());
  }
}

class ReportingLedgerRow {
  final String id;
  final ReportingLedgerRowType type;
  final DateTime date;
  final double amount;
  final String title;
  final String description;
  final String? category;
  final String? accountId;
  final String? transferAccountId;
  final bool isOutflow;
  final bool isInflow;
  final bool isAuditOnly;
  final ExpenseDto? expense;
  final IncomeDto? income;
  final ManualDepositDto? manualDeposit;
  final TransferDto? transfer;
  final SettlementDto? settlement;

  const ReportingLedgerRow({
    required this.id,
    required this.type,
    required this.date,
    required this.amount,
    required this.title,
    required this.description,
    this.category,
    this.accountId,
    this.transferAccountId,
    this.isOutflow = false,
    this.isInflow = false,
    this.isAuditOnly = false,
    this.expense,
    this.income,
    this.manualDeposit,
    this.transfer,
    this.settlement,
  });
}

class ReportingAccountSummary {
  final AccountDto account;
  final double deposited;
  final double spent;
  final double transferIn;
  final double transferOut;
  final int auditCount;

  const ReportingAccountSummary({
    required this.account,
    required this.deposited,
    required this.spent,
    required this.transferIn,
    required this.transferOut,
    required this.auditCount,
  });

  double get inflowTotal => deposited + transferIn;
  double get outflowTotal => spent + transferOut;
  double get netChange => inflowTotal - outflowTotal;
}

class ReportingLedgerSummary {
  final List<ReportingLedgerRow> rows;
  final List<AccountDto> accounts;

  const ReportingLedgerSummary({required this.rows, required this.accounts});

  Iterable<ReportingLedgerRow> get financialRows =>
      rows.where((row) => !row.isAuditOnly);

  double get totalSpent => rows.fold<double>(
    0,
    (total, row) =>
        total + (row.isOutflow && !row.isAuditOnly ? row.amount : 0),
  );

  double get totalDeposited => rows.fold<double>(
    0,
    (total, row) => total + (row.isInflow && !row.isAuditOnly ? row.amount : 0),
  );

  int get spentCount =>
      rows.where((row) => row.isOutflow && !row.isAuditOnly).length;

  int get depositCount =>
      rows.where((row) => row.isInflow && !row.isAuditOnly).length;

  int get auditCount => rows.where((row) => row.isAuditOnly).length;

  Map<String, ReportingAccountSummary> get accountSummaries {
    final deposited = <String, double>{};
    final spent = <String, double>{};
    final transferIn = <String, double>{};
    final transferOut = <String, double>{};
    final auditCounts = <String, int>{};

    for (final row in rows) {
      final accountId = row.accountId;
      if (accountId == null || accountId.isEmpty) continue;
      if (row.isAuditOnly) {
        auditCounts.update(accountId, (v) => v + 1, ifAbsent: () => 1);
        continue;
      }

      switch (row.type) {
        case ReportingLedgerRowType.transferIn:
          transferIn.update(
            accountId,
            (v) => v + row.amount,
            ifAbsent: () => row.amount,
          );
        case ReportingLedgerRowType.transferOut:
          transferOut.update(
            accountId,
            (v) => v + row.amount,
            ifAbsent: () => row.amount,
          );
        case ReportingLedgerRowType.expense ||
            ReportingLedgerRowType.settlementOut:
          spent.update(
            accountId,
            (v) => v + row.amount,
            ifAbsent: () => row.amount,
          );
        case ReportingLedgerRowType.income ||
            ReportingLedgerRowType.manualDeposit ||
            ReportingLedgerRowType.settlementIn:
          deposited.update(
            accountId,
            (v) => v + row.amount,
            ifAbsent: () => row.amount,
          );
        case ReportingLedgerRowType.balanceCorrection:
          break;
      }
    }

    return {
      for (final account in accounts)
        account.id: ReportingAccountSummary(
          account: account,
          deposited: deposited[account.id] ?? 0,
          spent: spent[account.id] ?? 0,
          transferIn: transferIn[account.id] ?? 0,
          transferOut: transferOut[account.id] ?? 0,
          auditCount: auditCounts[account.id] ?? 0,
        ),
    };
  }
}

class ReportingLedgerService {
  final ExpenseLocalDatasource _expenses;
  final IncomeLocalDatasource _incomes;
  final ManualDepositLocalDatasource _deposits;
  final SettlementLocalDatasource _settlements;
  final TransferLocalDatasource _transfers;
  final AccountLocalDatasource _accounts;

  ReportingLedgerService({
    required ExpenseLocalDatasource expenses,
    required IncomeLocalDatasource incomes,
    required ManualDepositLocalDatasource deposits,
    required SettlementLocalDatasource settlements,
    required TransferLocalDatasource transfers,
    required AccountLocalDatasource accounts,
  }) : _expenses = expenses,
       _incomes = incomes,
       _deposits = deposits,
       _settlements = settlements,
       _transfers = transfers,
       _accounts = accounts;

  Future<ReportingLedgerSummary> load({
    required String userId,
    required ReportingPeriod period,
  }) async {
    final accounts = (await _accounts.getAccounts())
        .where((account) => account.userId == userId)
        .toList();
    final accountIds = accounts.map((account) => account.id).toSet();
    final rows = <ReportingLedgerRow>[];

    final expenses = await _expenses.getExpenses(ownerUserId: userId);
    for (final expense in expenses) {
      if (!period.contains(expense.expenseDate)) continue;
      final share = _currentUserShare(expense, userId);
      if (share <= 0) continue;
      rows.add(
        ReportingLedgerRow(
          id: expense.id,
          type: ReportingLedgerRowType.expense,
          date: expense.expenseDate,
          amount: share,
          title: expense.title,
          description: expense.title,
          category: expense.category ?? ExpenseCategory.other.name,
          accountId: expense.accountId,
          isOutflow: true,
          expense: expense,
        ),
      );
    }

    final incomes = (await _incomes.fetchAll()).where(
      (income) => income.userId == userId && !income.isDeleted,
    );
    for (final income in incomes) {
      if (!period.contains(income.createdAt)) continue;
      rows.add(
        ReportingLedgerRow(
          id: income.id,
          type: ReportingLedgerRowType.income,
          date: income.createdAt,
          amount: income.amount,
          title: income.description.isEmpty ? 'Income' : income.description,
          description: income.description,
          accountId: income.accountId,
          isInflow: true,
          income: income,
        ),
      );
    }

    final deposits = (await _deposits.fetchAll()).where(
      (deposit) => deposit.userId.isEmpty || deposit.userId == userId,
    );
    for (final deposit in deposits) {
      if (!period.contains(deposit.createdAt)) continue;
      final isAuditOnly = deposit.isBalanceEdit;
      rows.add(
        ReportingLedgerRow(
          id: deposit.id,
          type: isAuditOnly
              ? ReportingLedgerRowType.balanceCorrection
              : ReportingLedgerRowType.manualDeposit,
          date: deposit.createdAt,
          amount: deposit.amount,
          title: isAuditOnly ? 'Balance correction' : 'Manual deposit',
          description: deposit.description,
          accountId: deposit.accountId,
          isInflow: !isAuditOnly,
          isAuditOnly: isAuditOnly,
          manualDeposit: deposit,
        ),
      );
    }

    final settlements = (await _settlements.getSettlements()).where(
      (settlement) =>
          settlement.status == SettlementStatus.confirmed &&
          (settlement.fromUserId == userId || settlement.toUserId == userId),
    );
    final seenSettlementIds = <String>{};
    for (final settlement in settlements) {
      if (!seenSettlementIds.add(settlement.id)) continue;
      final date = settlement.resolvedAt ?? settlement.createdAt;
      if (!period.contains(date)) continue;
      final isIncoming = settlement.toUserId == userId;
      rows.add(
        ReportingLedgerRow(
          id: settlement.id,
          type: isIncoming
              ? ReportingLedgerRowType.settlementIn
              : ReportingLedgerRowType.settlementOut,
          date: date,
          amount: settlement.amount,
          title: isIncoming ? 'Settlement received' : 'Settlement paid',
          description: isIncoming ? 'Settlement received' : 'Settlement paid',
          accountId: _settlementAccountId(settlement, isIncoming),
          isInflow: isIncoming,
          isOutflow: !isIncoming,
          settlement: settlement,
        ),
      );
    }

    final transfers = (await _transfers.fetchAll()).where(
      (transfer) =>
          transfer.fromUserId == userId ||
          transfer.toUserId == userId ||
          accountIds.contains(transfer.fromAccountId) ||
          accountIds.contains(transfer.toAccountId),
    );
    for (final transfer in transfers) {
      if (!period.contains(transfer.createdAt)) continue;
      if (accountIds.contains(transfer.fromAccountId)) {
        rows.add(
          ReportingLedgerRow(
            id: '${transfer.id}:out',
            type: ReportingLedgerRowType.transferOut,
            date: transfer.createdAt,
            amount: transfer.amount,
            title: 'Transfer out',
            description: transfer.description,
            accountId: transfer.fromAccountId,
            transferAccountId: transfer.toAccountId,
            isOutflow: true,
            transfer: transfer,
          ),
        );
      }
      if (accountIds.contains(transfer.toAccountId)) {
        rows.add(
          ReportingLedgerRow(
            id: '${transfer.id}:in',
            type: ReportingLedgerRowType.transferIn,
            date: transfer.createdAt,
            amount: transfer.amount,
            title: 'Transfer in',
            description: transfer.description,
            accountId: transfer.toAccountId,
            transferAccountId: transfer.fromAccountId,
            isInflow: true,
            transfer: transfer,
          ),
        );
      }
    }

    rows.sort((a, b) => b.date.compareTo(a.date));
    return ReportingLedgerSummary(rows: rows, accounts: accounts);
  }

  double _currentUserShare(ExpenseDto expense, String userId) {
    if (expense.expenseType == ExpenseType.personal) return expense.amount;
    for (final participant in expense.participants) {
      if (participant.userId == userId) return participant.amount;
    }
    return 0;
  }

  String? _settlementAccountId(SettlementDto settlement, bool isIncoming) {
    if (isIncoming) {
      return settlement.toAccountId ?? settlement.accountId;
    }
    return settlement.fromAccountId ?? settlement.accountId;
  }
}
