import 'package:famxpense/core/services/notification/notification_service.dart';
import 'package:famxpense/core/services/sync/sync_service.dart';
import 'package:famxpense/features/account/data/datasources/account_local_datasource.dart';
import 'package:famxpense/features/account/domain/repositories/account_repository.dart';
import 'package:famxpense/features/auth/data/datasources/local/auth_local_datasource.dart';
import 'package:famxpense/features/debt_ledger/data/datasources/debt_ledger_local_datasource.dart';
import 'package:famxpense/features/debt_ledger/domain/repositories/debt_ledger_repository.dart';
import 'package:famxpense/features/expenses/domain/repositories/expense_repository.dart';
import 'package:famxpense/features/notification/data/datasources/notification_local_datasource.dart';
import 'package:famxpense/features/partners/data/datasources/local/partnership_local_datasource.dart';
import 'package:famxpense/features/partners/data/datasources/remote/partnership_remote_datasource.dart';
import 'package:famxpense/features/partners/domain/repositories/partnership_repository.dart';
import 'package:famxpense/features/partners/domain/usecases/get_partnerships_usecase.dart';
import 'package:famxpense/features/partners/domain/usecases/search_user_usecase.dart';
import 'package:famxpense/features/partners/domain/usecases/send_partnership_request_usecase.dart';
import 'package:famxpense/features/settlement/data/datasources/remote/settlement_remote_datasource.dart';
import 'package:famxpense/features/settlement/domain/repositories/settlement_repository.dart';
import 'package:famxpense/shared/data/datasources/local/user_local_datasource.dart';
import 'package:famxpense/shared/domain/entities/expense/expense_entity.dart';
import 'package:famxpense/shared/domain/entities/expense/expense_participant_entity.dart';
import 'package:famxpense/shared/domain/entities/partnership/partnership_entity.dart';
import 'package:famxpense/shared/domain/entities/user/user_entity.dart';
import 'package:famxpense/shared/enums/expense_type.dart';
import 'package:famxpense/shared/enums/partnership_status.dart';
import 'package:famxpense/shared/enums/settlement_status.dart';
import 'package:famxpense/shared/enums/split_type.dart';
import 'package:famxpense/shared/enums/sync_status.dart';
import 'package:mocktail/mocktail.dart';

class MockDebtLedgerRepository extends Mock implements DebtLedgerRepository {}
class MockDebtLedgerLocalDatasource extends Mock implements DebtLedgerLocalDatasource {}
class MockSettlementRepository extends Mock implements SettlementRepository {}
class MockAccountRepository extends Mock implements AccountRepository {}
class MockAccountLocalDatasource extends Mock implements AccountLocalDatasource {}
class MockNotificationLocalDatasource extends Mock implements NotificationLocalDatasource {}
class MockAuthLocalDatasource extends Mock implements AuthLocalDatasource {}
class MockSettlementRemoteDatasource extends Mock implements SettlementRemoteDatasource {}
class MockSyncService extends Mock implements SyncService {}

/// Expense / Partners
class MockExpenseRepository extends Mock implements ExpenseRepository {}
class MockUserLocalDatasource extends Mock implements UserLocalDatasource {}
class MockNotificationService extends Mock implements NotificationService {}
class MockSearchUserUsecase extends Mock implements SearchUserUsecase {}
class MockSendPartnershipRequestUsecase extends Mock implements SendPartnershipRequestUsecase {}
class MockGetPartnershipsUsecase extends Mock implements GetPartnershipsUsecase {}
class MockPartnershipRepository extends Mock implements PartnershipRepository {}
class MockPartnershipLocalDatasource extends Mock implements PartnershipLocalDatasource {}
class MockPartnershipRemoteDatasource extends Mock implements PartnershipRemoteDatasource {}

/// Register fallback values for types used with `any()` matchers.
void registerFallbacks() {
  registerFallbackValue(SettlementStatus.pending);
  registerFallbackValue(PartnershipStatus.pending);
  registerFallbackValue(PartnershipEntity(
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
  ));
  registerFallbackValue(UserEntity(
    id: '',
    name: '',
    nickname: '',
    email: '',
    createdAt: DateTime(2026),
    updatedAt: DateTime(2026),
  ));
  registerFallbackValue(ExpenseEntity(
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
  ));
}
