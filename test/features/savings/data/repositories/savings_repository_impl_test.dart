import 'package:famxpense/features/savings/data/repositories/savings_repository_impl.dart';
import 'package:famxpense/shared/data/transformers/dtos/savings/monthly_saving_dto.dart';
import 'package:famxpense/shared/data/transformers/dtos/account/account_dto.dart';
import 'package:famxpense/shared/enums/account_type.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../../mocks.dart';

void main() {
  late MockSavingsLocalDatasource mockLocal;
  late MockAccountLocalDatasource mockAccountLocal;
  late MockMonthlySavingRemoteDatasource mockRemote;
  late MockRefreshNotifier mockRefreshNotifier;
  late SavingsRepositoryImpl repository;

  final now = DateTime(2026, 7, 27, 12, 0, 0).toUtc();
  final currentMonth = DateTime.now();

  setUp(() {
    registerFallbacks();
    mockLocal = MockSavingsLocalDatasource();
    mockAccountLocal = MockAccountLocalDatasource();
    mockRemote = MockMonthlySavingRemoteDatasource();
    mockRefreshNotifier = MockRefreshNotifier();
    repository = SavingsRepositoryImpl(
      local: mockLocal,
      accountLocal: mockAccountLocal,
      remote: mockRemote,
      refreshNotifier: mockRefreshNotifier,
    );
    when(() => mockAccountLocal.getAccounts()).thenAnswer(
      (_) async => [
        AccountDto(
          id: 'acct-1',
          userId: 'user-a',
          accountName: 'Savings',
          accountType: AccountType.bank,
          currentBalance: 5000,
          createdAt: now,
          updatedAt: now,
          isSavings: true,
        ),
      ],
    );
  });

  group('computeCurrentMonth', () {
    test('creates new snapshot when no existing snapshot', () async {
      when(
        () => mockLocal.getSnapshot(
          'acct-1',
          currentMonth.year,
          currentMonth.month,
        ),
      ).thenAnswer((_) async => null);
      when(
        () => mockLocal.getSnapshotsByAccount('acct-1'),
      ).thenAnswer((_) async => []);
      when(() => mockLocal.saveSnapshot(any())).thenAnswer((_) async {});
      when(() => mockRemote.saveSnapshot(any())).thenAnswer((_) async {});
      when(() => mockAccountLocal.getAccounts()).thenAnswer(
        (_) async => [
          AccountDto(
            id: 'acct-1',
            userId: 'user-a',
            accountName: 'Savings',
            accountType: AccountType.bank,
            currentBalance: 5000,
            createdAt: now,
            updatedAt: now,
            isSavings: true,
          ),
        ],
      );

      final result = await repository.computeCurrentMonth(
        'acct-1',
        5000.0,
        10000.0,
      );

      expect(result.accountId, 'acct-1');
      expect(result.savedAmount, 5000.0);
      expect(result.openingBalance, 0);
      expect(result.closingBalance, 5000.0);
      expect(result.achievementPercent, 50.0);
      expect(
        result.id,
        'user-a-acct-1-${currentMonth.year}-${currentMonth.month.toString().padLeft(2, '0')}',
      );
      verify(() => mockLocal.saveSnapshot(any())).called(2);
    });

    test('updates existing snapshot with new balance', () async {
      final existingDto = MonthlySavingDto(
        id: 'ms-1',
        accountId: 'acct-1',
        year: 2026,
        month: 7,
        goalAmount: 10000.0,
        savedAmount: 7000.0,
        openingBalance: 0.0,
        closingBalance: 7000.0,
        achievementPercent: 70.0,
        userId: 'user-a',
      );
      when(
        () => mockLocal.getSnapshot(
          'acct-1',
          currentMonth.year,
          currentMonth.month,
        ),
      ).thenAnswer((_) async => existingDto);
      when(() => mockLocal.saveSnapshot(any())).thenAnswer((_) async {});
      when(() => mockRemote.saveSnapshot(any())).thenAnswer((_) async {});

      final result = await repository.computeCurrentMonth(
        'acct-1',
        2000.0,
        10000.0,
      );

      expect(result.savedAmount, 2000.0);
      expect(result.openingBalance, 0);
      expect(result.closingBalance, 2000.0);
      expect(result.achievementPercent, 20.0);
      verify(() => mockLocal.saveSnapshot(any())).called(2);
    });

    test(
      'computes negative saved amount when balance is below opening',
      () async {
        final existingDto = MonthlySavingDto(
          id: 'ms-1',
          accountId: 'acct-1',
          year: 2026,
          month: 7,
          goalAmount: 10000.0,
          savedAmount: 7000.0,
          openingBalance: 7000.0,
          closingBalance: 7000.0,
          achievementPercent: 70.0,
          userId: 'user-a',
        );
        when(
          () => mockLocal.getSnapshot(
            'acct-1',
            currentMonth.year,
            currentMonth.month,
          ),
        ).thenAnswer((_) async => existingDto);
        when(() => mockLocal.saveSnapshot(any())).thenAnswer((_) async {});
        when(() => mockRemote.saveSnapshot(any())).thenAnswer((_) async {});

        final result = await repository.computeCurrentMonth(
          'acct-1',
          2000.0,
          10000.0,
        );

        expect(result.savedAmount, -5000.0);
        expect(result.achievementPercent, -50.0);
        verify(() => mockLocal.saveSnapshot(any())).called(2);
      },
    );
  });

  group('getTotalSavedYearToDate', () {
    test(
      'sums savedAmount for current year across all savings accounts',
      () async {
        final savingsAccountDto = AccountDto(
          id: 'acct-savings-1',
          userId: 'user-a',
          accountName: 'Savings',
          accountType: AccountType.bank,
          currentBalance: 5000.0,
          createdAt: now,
          updatedAt: now,
          isSavings: true,
        );
        when(
          () => mockAccountLocal.getAccounts(),
        ).thenAnswer((_) async => [savingsAccountDto]);

        final janDto = MonthlySavingDto(
          id: 'ms-jan',
          accountId: 'acct-savings-1',
          year: 2026,
          month: 1,
          goalAmount: 0,
          savedAmount: 3000.0,
          openingBalance: 0,
          closingBalance: 3000.0,
          achievementPercent: 0,
        );
        final julDto = MonthlySavingDto(
          id: 'ms-jul',
          accountId: 'acct-savings-1',
          year: 2026,
          month: 7,
          goalAmount: 0,
          savedAmount: 2000.0,
          openingBalance: 3000.0,
          closingBalance: 5000.0,
          achievementPercent: 0,
        );
        when(
          () => mockLocal.getSnapshotsByAccount('acct-savings-1'),
        ).thenAnswer((_) async => [janDto, julDto]);

        final total = await repository.getTotalSavedYearToDate('user-a');

        expect(total, 5000.0);
      },
    );

    test('returns 0 when no savings accounts exist', () async {
      when(() => mockAccountLocal.getAccounts()).thenAnswer((_) async => []);

      final total = await repository.getTotalSavedYearToDate('user-a');

      expect(total, 0);
    });

    test('skips snapshots from previous years', () async {
      final savingsAccountDto = AccountDto(
        id: 'acct-savings-1',
        userId: 'user-a',
        accountName: 'Savings',
        accountType: AccountType.bank,
        currentBalance: 5000.0,
        createdAt: now,
        updatedAt: now,
        isSavings: true,
      );
      when(
        () => mockAccountLocal.getAccounts(),
      ).thenAnswer((_) async => [savingsAccountDto]);

      final oldDto = MonthlySavingDto(
        id: 'ms-old',
        accountId: 'acct-savings-1',
        year: 2025,
        month: 12,
        goalAmount: 0,
        savedAmount: 10000.0,
        openingBalance: 0,
        closingBalance: 10000.0,
        achievementPercent: 0,
      );
      when(
        () => mockLocal.getSnapshotsByAccount('acct-savings-1'),
      ).thenAnswer((_) async => [oldDto]);

      final total = await repository.getTotalSavedYearToDate('user-a');

      expect(total, 0);
    });
  });

  group('getTotalSavedForMonth', () {
    test('sums only the requested month across savings accounts', () async {
      final secondAccount = AccountDto(
        id: 'acct-2',
        userId: 'user-a',
        accountName: 'Second Savings',
        accountType: AccountType.bank,
        currentBalance: 3000,
        createdAt: now,
        updatedAt: now,
        isSavings: true,
      );
      when(() => mockAccountLocal.getAccounts()).thenAnswer(
        (_) async => [
          AccountDto(
            id: 'acct-1',
            userId: 'user-a',
            accountName: 'Savings',
            accountType: AccountType.bank,
            currentBalance: 5000,
            createdAt: now,
            updatedAt: now,
            isSavings: true,
          ),
          secondAccount,
        ],
      );
      when(() => mockLocal.getSnapshot('acct-1', 2026, 8)).thenAnswer(
        (_) async => MonthlySavingDto(
          id: 'aug-1',
          accountId: 'acct-1',
          year: 2026,
          month: 8,
          goalAmount: 0,
          savedAmount: 1200,
          openingBalance: 5000,
          closingBalance: 6200,
          achievementPercent: 0,
        ),
      );
      when(() => mockLocal.getSnapshot('acct-2', 2026, 8)).thenAnswer(
        (_) async => MonthlySavingDto(
          id: 'aug-2',
          accountId: 'acct-2',
          year: 2026,
          month: 8,
          goalAmount: 0,
          savedAmount: 800,
          openingBalance: 3000,
          closingBalance: 3800,
          achievementPercent: 0,
        ),
      );

      final total = await repository.getTotalSavedForMonth('user-a', 2026, 8);

      expect(total, 2000);
    });

    test('returns zero when the current month has no snapshot', () async {
      when(
        () => mockLocal.getSnapshot('acct-1', 2026, 8),
      ).thenAnswer((_) async => null);

      final total = await repository.getTotalSavedForMonth('user-a', 2026, 8);

      expect(total, 0);
    });
  });

  group('getAccountHistory', () {
    test('returns snapshots sorted by year/month descending', () async {
      final julDto = MonthlySavingDto(
        id: 'ms-jul',
        accountId: 'acct-1',
        year: 2026,
        month: 7,
        goalAmount: 0,
        savedAmount: 2000.0,
        openingBalance: 0,
        closingBalance: 2000.0,
        achievementPercent: 0,
      );
      final augDto = MonthlySavingDto(
        id: 'ms-aug',
        accountId: 'acct-1',
        year: 2026,
        month: 8,
        goalAmount: 0,
        savedAmount: 3000.0,
        openingBalance: 2000.0,
        closingBalance: 5000.0,
        achievementPercent: 0,
      );
      when(
        () => mockLocal.getSnapshotsByAccount('acct-1'),
      ).thenAnswer((_) async => [julDto, augDto]);

      final history = await repository.getAccountHistory('acct-1');

      expect(history.length, 2);
      expect(history[0].month, 8);
      expect(history[1].month, 7);
    });

    test(
      'deduplicates legacy snapshots for the same account month using updatedAt',
      () async {
        final older = MonthlySavingDto(
          id: 'legacy-random-id',
          accountId: 'acct-1',
          year: 2026,
          month: 7,
          goalAmount: 10000,
          savedAmount: 1000,
          openingBalance: 0,
          closingBalance: 1000,
          achievementPercent: 10,
          updatedAt: now,
        );
        final newer = older.copyWith(
          id: 'canonical-id',
          savedAmount: 2500,
          closingBalance: 2500,
          achievementPercent: 25,
          updatedAt: now.add(const Duration(minutes: 1)),
        );
        when(
          () => mockLocal.getSnapshotsByAccount('acct-1'),
        ).thenAnswer((_) async => [older, newer]);

        final history = await repository.getAccountHistory('acct-1');

        expect(history, hasLength(1));
        expect(history.single.id, 'canonical-id');
        expect(history.single.savedAmount, 2500);
      },
    );
  });

  group('finalizeMonth', () {
    test('marks snapshot as completed', () async {
      final dto = MonthlySavingDto(
        id: 'ms-1',
        accountId: 'acct-1',
        year: 2026,
        month: 7,
        goalAmount: 10000.0,
        savedAmount: 5000.0,
        openingBalance: 0,
        closingBalance: 5000.0,
        achievementPercent: 50.0,
        isCompleted: false,
        userId: 'user-a',
      );
      when(
        () => mockLocal.getSnapshot('acct-1', 2026, 7),
      ).thenAnswer((_) async => dto);
      when(() => mockLocal.saveSnapshot(any())).thenAnswer((_) async {});
      when(() => mockRemote.saveSnapshot(any())).thenAnswer((_) async {});

      await repository.finalizeMonth('acct-1', 2026, 7);

      verify(
        () => mockLocal.saveSnapshot(
          any(that: predicate<MonthlySavingDto>((s) => s.isCompleted)),
        ),
      ).called(2);
    });

    test('does nothing if already completed', () async {
      final dto = MonthlySavingDto(
        id: 'ms-1',
        accountId: 'acct-1',
        year: 2026,
        month: 7,
        goalAmount: 10000.0,
        savedAmount: 5000.0,
        openingBalance: 0,
        closingBalance: 5000.0,
        achievementPercent: 50.0,
        isCompleted: true,
      );
      when(
        () => mockLocal.getSnapshot('acct-1', 2026, 7),
      ).thenAnswer((_) async => dto);

      await repository.finalizeMonth('acct-1', 2026, 7);

      verifyNever(() => mockLocal.saveSnapshot(any()));
    });

    test('does nothing when no snapshot exists', () async {
      when(
        () => mockLocal.getSnapshot('acct-1', 2026, 7),
      ).thenAnswer((_) async => null);

      await repository.finalizeMonth('acct-1', 2026, 7);

      verifyNever(() => mockLocal.saveSnapshot(any()));
    });
  });
}
