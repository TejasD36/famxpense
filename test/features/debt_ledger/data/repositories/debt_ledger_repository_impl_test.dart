import 'package:famxpense/features/debt_ledger/data/datasources/debt_ledger_local_datasource.dart';
import 'package:famxpense/features/debt_ledger/data/datasources/remote/debt_ledger_remote_datasource.dart';
import 'package:famxpense/features/debt_ledger/data/repositories/debt_ledger_repository_impl.dart';
import 'package:famxpense/shared/data/transformers/dtos/debt_ledger/debt_ledger_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockDebtLocal extends Mock implements DebtLedgerLocalDatasource {}

class _MockDebtRemote extends Mock implements DebtLedgerRemoteDatasource {}

void main() {
  late _MockDebtLocal local;
  late _MockDebtRemote remote;
  late DebtLedgerRepositoryImpl repository;
  final now = DateTime(2026, 7, 31).toUtc();

  setUpAll(() {
    registerFallbackValue(
      DebtLedgerDto(
        id: '',
        userA: '',
        userB: '',
        netBalance: 0,
        updatedAt: now,
      ),
    );
  });

  setUp(() {
    local = _MockDebtLocal();
    remote = _MockDebtRemote();
    repository = DebtLedgerRepositoryImpl(
      localDatasource: local,
      remoteDatasource: remote,
    );
  });

  test('an offline retry does not apply the local debt twice', () async {
    final ledgers = <DebtLedgerDto>[];
    when(() => local.getLedgers()).thenAnswer((_) async => ledgers);
    when(() => local.saveLedger(any())).thenAnswer((invocation) async {
      final saved = invocation.positionalArguments.single as DebtLedgerDto;
      ledgers
        ..removeWhere((ledger) => ledger.id == saved.id)
        ..add(saved);
    });
    when(
      () => remote.adjustDebt(
        userA: 'user-a',
        userB: 'user-b',
        delta: -25,
        mutationId: 'expense-1-user-b',
        updatedAt: any(named: 'updatedAt'),
      ),
    ).thenThrow(Exception('Offline'));

    await repository.updateDebt(
      'user-a',
      'user-b',
      -25,
      mutationId: 'expense-1-user-b',
    );
    await repository.updateDebt(
      'user-a',
      'user-b',
      -25,
      mutationId: 'expense-1-user-b',
    );

    expect(ledgers.single.netBalance, -25);
    expect(ledgers.single.pendingMutations, {'expense-1-user-b': -25});
  });
}
