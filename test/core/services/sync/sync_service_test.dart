import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:famxpense/core/services/sync/sync_service.dart';
import 'package:famxpense/features/account/data/datasources/account_local_datasource.dart';
import 'package:famxpense/features/account/data/datasources/remote/account_remote_datasource.dart';
import 'package:famxpense/features/debt_ledger/data/datasources/debt_ledger_local_datasource.dart';
import 'package:famxpense/features/debt_ledger/data/datasources/remote/debt_ledger_remote_datasource.dart';
import 'package:famxpense/features/expenses/data/datasources/local/expense_local_datasource.dart';
import 'package:famxpense/features/expenses/data/datasources/remote/expense_remote_datasource.dart';
import 'package:famxpense/features/income/data/datasources/income_local_datasource.dart';
import 'package:famxpense/features/income/data/datasources/remote/income_remote_datasource.dart';
import 'package:famxpense/features/notification/data/datasources/notification_local_datasource.dart';
import 'package:famxpense/features/notification/data/datasources/remote/notification_remote_datasource.dart';
import 'package:famxpense/features/partners/data/datasources/remote/partnership_remote_datasource.dart';
import 'package:famxpense/features/savings/data/datasources/savings_local_datasource.dart';
import 'package:famxpense/features/savings/data/datasources/remote/monthly_saving_remote_datasource.dart';
import 'package:famxpense/features/savings/data/datasources/transfer_local_datasource.dart';
import 'package:famxpense/features/savings/data/datasources/remote/transfer_remote_datasource.dart';
import 'package:famxpense/features/settlement/data/datasources/settlement_local_datasource.dart';
import 'package:famxpense/features/settlement/data/datasources/remote/settlement_remote_datasource.dart';
import 'package:famxpense/shared/data/datasources/local/user_local_datasource.dart';
import 'package:famxpense/shared/data/datasources/remote/user_remote_datasource.dart';
import 'package:famxpense/shared/data/transformers/dtos/notification/notification_dto.dart';
import 'package:famxpense/shared/enums/notification_type.dart';

class MockExpenseLocalDatasource extends Mock implements ExpenseLocalDatasource {}
class MockExpenseRemoteDatasource extends Mock implements ExpenseRemoteDatasource {}
class MockAccountLocalDataSource extends Mock implements AccountLocalDatasource {}
class MockAccountRemoteDataSource extends Mock implements AccountRemoteDatasource {}
class MockDebtLedgerLocal extends Mock implements DebtLedgerLocalDatasource {}
class MockDebtLedgerRemote extends Mock implements DebtLedgerRemoteDatasource {}
class MockSettlementLocal extends Mock implements SettlementLocalDatasource {}
class MockSettlementRemote extends Mock implements SettlementRemoteDatasource {}
class MockUserLocal extends Mock implements UserLocalDatasource {}
class MockUserRemote extends Mock implements UserRemoteDatasource {}
class MockPartnershipRemote extends Mock implements PartnershipRemoteDatasource {}
class MockIncomeLocal extends Mock implements IncomeLocalDatasource {}
class MockIncomeRemote extends Mock implements IncomeRemoteDatasource {}
class MockNotificationLocal extends Mock implements NotificationLocalDatasource {}
class MockNotificationRemote extends Mock implements NotificationRemoteDatasource {}
class MockTransferLocal extends Mock implements TransferLocalDatasource {}
class MockTransferRemote extends Mock implements TransferRemoteDatasource {}
class MockSavingsLocalDatasource extends Mock implements SavingsLocalDatasource {}
class MockMonthlySavingRemoteDatasource extends Mock implements MonthlySavingRemoteDatasource {}

void main() {
  setUpAll(() {
    registerFallbackValue(
      NotificationDto(
        id: 'fallback',
        userId: 'fallback',
        title: '',
        message: '',
        type: NotificationType.partnerRequest,
        createdAt: DateTime(2026, 1, 1),
      ),
    );
  });

  late SyncService syncService;
  late MockNotificationLocal notificationLocal;
  late MockNotificationRemote notificationRemote;
  late MockTransferLocal transferLocal;
  late MockTransferRemote transferRemote;
  late MockExpenseLocalDatasource expenseLocal;
  late MockExpenseRemoteDatasource expenseRemote;
  late MockAccountLocalDataSource accountLocal;
  late MockAccountRemoteDataSource accountRemote;
  late MockDebtLedgerLocal debtLedgerLocal;
  late MockDebtLedgerRemote debtLedgerRemote;
  late MockSettlementLocal settlementLocal;
  late MockSettlementRemote settlementRemote;
  late MockUserLocal userLocal;
  late MockUserRemote userRemote;
  late MockPartnershipRemote partnershipRemote;
  late MockIncomeLocal incomeLocal;
  late MockIncomeRemote incomeRemote;

  setUp(() {
    expenseLocal = MockExpenseLocalDatasource();
    expenseRemote = MockExpenseRemoteDatasource();
    accountLocal = MockAccountLocalDataSource();
    accountRemote = MockAccountRemoteDataSource();
    debtLedgerLocal = MockDebtLedgerLocal();
    debtLedgerRemote = MockDebtLedgerRemote();
    settlementLocal = MockSettlementLocal();
    settlementRemote = MockSettlementRemote();
    userLocal = MockUserLocal();
    userRemote = MockUserRemote();
    partnershipRemote = MockPartnershipRemote();
    incomeLocal = MockIncomeLocal();
    incomeRemote = MockIncomeRemote();
    notificationLocal = MockNotificationLocal();
    notificationRemote = MockNotificationRemote();
    transferLocal = MockTransferLocal();
    transferRemote = MockTransferRemote();

    syncService = SyncService(
      expenseLocal: expenseLocal,
      expenseRemote: expenseRemote,
      accountLocal: accountLocal,
      accountRemote: accountRemote,
      debtLedgerLocal: debtLedgerLocal,
      debtLedgerRemote: debtLedgerRemote,
      settlementLocal: settlementLocal,
      settlementRemote: settlementRemote,
      userLocal: userLocal,
      userRemote: userRemote,
      partnershipRemote: partnershipRemote,
      incomeLocal: incomeLocal,
      incomeRemote: incomeRemote,
      notificationLocal: notificationLocal,
      notificationRemote: notificationRemote,
      transferLocal: transferLocal,
      transferRemote: transferRemote,
      monthlySavingLocal: MockSavingsLocalDatasource(),
      monthlySavingRemote: MockMonthlySavingRemoteDatasource(),
    );
  });

  group('syncAll', () {
    test('returns false when sync is already in progress', () async {
      when(() => expenseLocal.getPendingExpenses(ownerUserId: any(named: 'ownerUserId')))
          .thenAnswer((_) async => []);
      when(() => expenseRemote.fetchExpenses(userId: any(named: 'userId')))
          .thenAnswer((_) async => []);
      when(() => expenseLocal.saveExpenses(any())).thenAnswer((_) async {});
      when(() => expenseLocal.clearOldSyncedExpenses(ownerUserId: any(named: 'ownerUserId')))
          .thenAnswer((_) async {});
      when(() => accountLocal.getAccounts()).thenAnswer((_) async => []);
      when(() => accountRemote.fetchAccounts(userId: any(named: 'userId')))
          .thenAnswer((_) async => []);
      when(() => debtLedgerLocal.getLedgers()).thenAnswer((_) async => []);
      when(() => debtLedgerRemote.fetchLedgers(userId: any(named: 'userId')))
          .thenAnswer((_) async => []);
      when(() => settlementLocal.getSettlements()).thenAnswer((_) async => []);
      when(() => settlementRemote.fetchSettlements(userId: any(named: 'userId')))
          .thenAnswer((_) async => []);
      when(() => partnershipRemote.getPartnerships(userId: any(named: 'userId')))
          .thenAnswer((_) async => []);
      when(() => incomeLocal.fetchAll()).thenAnswer((_) async => []);
      when(() => incomeRemote.fetchIncomes(userId: any(named: 'userId')))
          .thenAnswer((_) async => []);
      when(() => notificationLocal.getNotifications()).thenAnswer((_) async => []);
      when(() => notificationRemote.fetchNotifications(userId: any(named: 'userId')))
          .thenAnswer((_) async => []);

      final first = syncService.syncAll(userId: 'user-a');
      final second = await syncService.syncAll(userId: 'user-a');
      await first;

      expect(second, false);
    });
  });

  group('syncNotifications', () {
    NotificationDto createNotification({
      required String id,
      required String userId,
      bool isOwn = true,
    }) {
      return NotificationDto(
        id: id,
        userId: userId,
        title: 'Notification $id',
        message: 'Message $id',
        type: NotificationType.partnerRequest,
        isRead: false,
        createdAt: DateTime(2026, 7, 1),
      );
    }

    test('skips uploading notifications where userId != currentUserId', () async {
      final ownNotification = createNotification(id: 'n-1', userId: 'user-a');
      final otherNotification = createNotification(id: 'n-2', userId: 'user-b');

      when(() => notificationLocal.getNotifications()).thenAnswer((_) async => [ownNotification, otherNotification]);
      when(() => notificationRemote.fetchNotifications(userId: any(named: 'userId')))
          .thenAnswer((_) async => []);
      when(() => notificationRemote.uploadNotification(any())).thenAnswer((_) async {});
      when(() => notificationLocal.saveNotification(any())).thenAnswer((_) async {});

      await syncService.syncNotifications(userId: 'user-a');

      verify(() => notificationRemote.uploadNotification(ownNotification)).called(1);
      verifyNever(() => notificationRemote.uploadNotification(otherNotification));
    });

    test('uploads own notifications and saves remote ones', () async {
      final localNotification = createNotification(id: 'n-1', userId: 'user-a');
      final remoteNotification = createNotification(id: 'n-2', userId: 'user-a');

      when(() => notificationLocal.getNotifications()).thenAnswer((_) async => [localNotification]);
      when(() => notificationRemote.fetchNotifications(userId: any(named: 'userId')))
          .thenAnswer((_) async => [remoteNotification]);
      when(() => notificationRemote.uploadNotification(any())).thenAnswer((_) async {});
      when(() => notificationLocal.saveNotification(any())).thenAnswer((_) async {});

      await syncService.syncNotifications(userId: 'user-a');

      verify(() => notificationRemote.uploadNotification(localNotification)).called(1);
      verify(() => notificationLocal.saveNotification(remoteNotification)).called(1);
    });

    test('handles upload errors gracefully', () async {
      final notification = createNotification(id: 'n-1', userId: 'user-a');

      when(() => notificationLocal.getNotifications()).thenAnswer((_) async => [notification]);
      when(() => notificationRemote.fetchNotifications(userId: any(named: 'userId')))
          .thenAnswer((_) async => []);
      when(() => notificationRemote.uploadNotification(any())).thenThrow(Exception('Upload failed'));

      await syncService.syncNotifications(userId: 'user-a');

      verify(() => notificationRemote.uploadNotification(notification)).called(1);
    });
  });
}
