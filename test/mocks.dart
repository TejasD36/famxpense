import 'package:famxpense/features/account/data/datasources/account_local_datasource.dart';
import 'package:famxpense/features/account/domain/repositories/account_repository.dart';
import 'package:famxpense/features/auth/data/datasources/local/auth_local_datasource.dart';
import 'package:famxpense/features/debt_ledger/data/datasources/debt_ledger_local_datasource.dart';
import 'package:famxpense/features/debt_ledger/domain/repositories/debt_ledger_repository.dart';
import 'package:famxpense/features/notification/data/datasources/notification_local_datasource.dart';
import 'package:famxpense/features/settlement/data/datasources/remote/settlement_remote_datasource.dart';
import 'package:famxpense/features/settlement/domain/repositories/settlement_repository.dart';
import 'package:famxpense/shared/enums/settlement_status.dart';
import 'package:mocktail/mocktail.dart';

class MockDebtLedgerRepository extends Mock implements DebtLedgerRepository {}
class MockDebtLedgerLocalDatasource extends Mock implements DebtLedgerLocalDatasource {}
class MockSettlementRepository extends Mock implements SettlementRepository {}
class MockAccountRepository extends Mock implements AccountRepository {}
class MockAccountLocalDatasource extends Mock implements AccountLocalDatasource {}
class MockNotificationLocalDatasource extends Mock implements NotificationLocalDatasource {}
class MockAuthLocalDatasource extends Mock implements AuthLocalDatasource {}
class MockSettlementRemoteDatasource extends Mock implements SettlementRemoteDatasource {}

/// Register fallback values for enum types used with `any()` matchers.
void registerFallbacks() {
  registerFallbackValue(SettlementStatus.pending);
}
