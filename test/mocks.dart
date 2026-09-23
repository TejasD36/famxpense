import 'package:famxpense/core/services/notification/notification_service.dart';
import 'package:famxpense/core/services/refresh/refresh_notifier.dart';
import 'package:famxpense/core/services/sync/sync_service.dart';
import 'package:famxpense/features/account/data/datasources/account_local_datasource.dart';
import 'package:famxpense/features/account/domain/repositories/account_repository.dart';
import 'package:famxpense/features/auth/data/datasources/local/auth_local_datasource.dart';
import 'package:famxpense/features/debt_ledger/data/datasources/debt_ledger_local_datasource.dart';
import 'package:famxpense/features/debt_ledger/domain/repositories/debt_ledger_repository.dart';
import 'package:famxpense/features/expenses/domain/repositories/expense_repository.dart';
import 'package:famxpense/features/income/data/datasources/income_local_datasource.dart';
import 'package:famxpense/features/income/data/datasources/remote/income_remote_datasource.dart';
import 'package:famxpense/features/income/domain/repositories/income_repository.dart';
import 'package:famxpense/features/notification/data/datasources/notification_local_datasource.dart';
import 'package:famxpense/features/partners/data/datasources/local/partnership_local_datasource.dart';
import 'package:famxpense/features/partners/data/datasources/remote/partnership_remote_datasource.dart';
import 'package:famxpense/features/partners/domain/repositories/partnership_repository.dart';
import 'package:famxpense/features/partners/domain/usecases/get_partnerships_usecase.dart';
import 'package:famxpense/features/partners/domain/usecases/search_user_usecase.dart';
import 'package:famxpense/features/partners/domain/usecases/send_partnership_request_usecase.dart';
import 'package:famxpense/features/savings/data/datasources/savings_local_datasource.dart';
import 'package:famxpense/features/savings/data/datasources/remote/monthly_saving_remote_datasource.dart';
import 'package:famxpense/features/savings/data/datasources/transfer_local_datasource.dart';
import 'package:famxpense/features/savings/data/datasources/remote/transfer_remote_datasource.dart';
import 'package:famxpense/features/savings/domain/repositories/savings_repository.dart';
import 'package:famxpense/features/settlement/data/datasources/remote/settlement_remote_datasource.dart';
import 'package:famxpense/features/settlement/domain/repositories/settlement_repository.dart';
import 'package:famxpense/shared/data/datasources/local/user_local_datasource.dart';
import 'package:famxpense/shared/data/transformers/dtos/income/income_dto.dart';
import 'package:famxpense/shared/data/transformers/dtos/savings/monthly_saving_dto.dart';
import 'package:famxpense/shared/data/transformers/dtos/transfer/transfer_dto.dart';
import 'package:famxpense/shared/domain/entities/expense/expense_entity.dart';
import 'package:famxpense/shared/domain/entities/income/income_entity.dart';
import 'package:famxpense/shared/domain/entities/partnership/partnership_entity.dart';
import 'package:famxpense/shared/domain/entities/savings/monthly_saving_entity.dart';
import 'package:famxpense/shared/domain/entities/transfer/transfer_entity.dart';
import 'package:famxpense/shared/domain/entities/user/user_entity.dart';
import 'package:famxpense/shared/enums/expense_type.dart';
import 'package:famxpense/shared/enums/income_source.dart';
import 'package:famxpense/shared/enums/partnership_status.dart';
import 'package:famxpense/shared/enums/settlement_status.dart';
import 'package:famxpense/shared/enums/split_type.dart';
import 'package:famxpense/shared/enums/sync_status.dart';
import 'package:mocktail/mocktail.dart';

class MockDebtLedgerRepository extends Mock implements DebtLedgerRepository {}

class MockDebtLedgerLocalDatasource extends Mock
    implements DebtLedgerLocalDatasource {}

class MockSettlementRepository extends Mock implements SettlementRepository {}

class MockAccountRepository extends Mock implements AccountRepository {}

class MockAccountLocalDatasource extends Mock
    implements AccountLocalDatasource {}

class MockNotificationLocalDatasource extends Mock
    implements NotificationLocalDatasource {}

class MockAuthLocalDatasource extends Mock implements AuthLocalDatasource {}

class MockSettlementRemoteDatasource extends Mock
    implements SettlementRemoteDatasource {}

class MockSyncService extends Mock implements SyncService {}

/// Expense / Partners
class MockExpenseRepository extends Mock implements ExpenseRepository {}

class MockUserLocalDatasource extends Mock implements UserLocalDatasource {}

class MockNotificationService extends Mock implements NotificationService {}

class MockSearchUserUsecase extends Mock implements SearchUserUsecase {}

class MockSendPartnershipRequestUsecase extends Mock
    implements SendPartnershipRequestUsecase {}

class MockGetPartnershipsUsecase extends Mock
    implements GetPartnershipsUsecase {}

class MockPartnershipRepository extends Mock implements PartnershipRepository {}

class MockPartnershipLocalDatasource extends Mock
    implements PartnershipLocalDatasource {}

class MockPartnershipRemoteDatasource extends Mock
    implements PartnershipRemoteDatasource {}

class MockIncomeLocalDatasource extends Mock implements IncomeLocalDatasource {}

class MockIncomeRemoteDatasource extends Mock
    implements IncomeRemoteDatasource {}

class MockIncomeRepository extends Mock implements IncomeRepository {}

class MockSavingsLocalDatasource extends Mock
    implements SavingsLocalDatasource {}

class MockMonthlySavingRemoteDatasource extends Mock
    implements MonthlySavingRemoteDatasource {}

class MockTransferLocalDatasource extends Mock
    implements TransferLocalDatasource {}

class MockTransferRemoteDatasource extends Mock
    implements TransferRemoteDatasource {}

class MockSavingsRepository extends Mock implements SavingsRepository {}

class MockRefreshNotifier extends Mock implements RefreshNotifier {}

/// Register fallback values for types used with `any()` matchers.
void registerFallbacks() {
  registerFallbackValue(SettlementStatus.pending);
  registerFallbackValue(PartnershipStatus.pending);
  registerFallbackValue(
    PartnershipEntity(
      id: '',
      senderId: '',
      senderEmail: '',
      senderNickname: '',
      receiverId: '',
      receiverEmail: '',
      receiverNickname: '',
      status: PartnershipStatus.pending,
      createdAt: DateTime(2026),
      updatedAt: DateTime(2026),
    ),
  );
  registerFallbackValue(
    UserEntity(
      id: '',
      name: '',
      nickname: '',
      email: '',
      createdAt: DateTime(2026),
      updatedAt: DateTime(2026),
    ),
  );
  registerFallbackValue(
    ExpenseEntity(
      id: '',
      title: '',
      amount: 0,
      paidByUserId: '',
      ownerUserId: '',
      expenseType: ExpenseType.personal,
      splitType: SplitType.equal,
      participants: [],
      expenseDate: DateTime(2026),
      createdAt: DateTime(2026),
      updatedAt: DateTime(2026),
      syncStatus: SyncStatus.synced,
    ),
  );
  registerFallbackValue(
    IncomeEntity(
      id: '',
      userId: '',
      accountId: '',
      amount: 0,
      source: IncomeSource.other,
      description: '',
      createdAt: DateTime(2026),
      updatedAt: DateTime(2026),
    ),
  );
  registerFallbackValue(IncomeSource.other);
  registerFallbackValue(
    MonthlySavingEntity(
      id: '',
      accountId: '',
      year: 2026,
      month: 1,
      goalAmount: 0,
      savedAmount: 0,
      openingBalance: 0,
      closingBalance: 0,
      achievementPercent: 0,
      userId: '',
    ),
  );
  registerFallbackValue(
    TransferEntity(
      id: '',
      fromAccountId: '',
      toAccountId: '',
      fromUserId: '',
      toUserId: '',
      amount: 0,
      description: '',
      createdAt: DateTime(2026),
      updatedAt: DateTime(2026),
    ),
  );
  registerFallbackValue(
    IncomeDto(
      id: '',
      userId: '',
      accountId: '',
      amount: 0,
      source: IncomeSource.other,
      description: '',
      createdAt: DateTime(2026),
      updatedAt: DateTime(2026),
    ),
  );
  registerFallbackValue(
    MonthlySavingDto(
      id: '',
      accountId: '',
      year: 2026,
      month: 1,
      goalAmount: 0,
      savedAmount: 0,
      openingBalance: 0,
      closingBalance: 0,
      achievementPercent: 0,
      userId: '',
    ),
  );
  registerFallbackValue(
    TransferDto(
      id: '',
      fromAccountId: '',
      toAccountId: '',
      fromUserId: '',
      toUserId: '',
      amount: 0,
      description: '',
      createdAt: DateTime(2026),
      updatedAt: DateTime(2026),
    ),
  );
}
