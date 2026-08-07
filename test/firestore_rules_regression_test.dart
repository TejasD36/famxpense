import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'mutation rules permit first-write transaction reads without listing',
    () {
      final rules = File('firestore.rules').readAsStringSync();

      for (final collection in [
        'account_balance_mutations',
        'debt_ledger_mutations',
      ]) {
        final start = rules.indexOf('match /$collection/');
        expect(start, isNonNegative, reason: '$collection rules must exist');
        final nextMatch = rules.indexOf('\n    match /', start + 1);
        final block = rules.substring(
          start,
          nextMatch == -1 ? rules.length : nextMatch,
        );

        expect(
          block,
          contains('allow get:'),
          reason: 'transactions must read a missing mutation before create',
        );
        expect(
          block,
          contains('!exists('),
          reason: 'the first mutation does not exist yet',
        );
        expect(
          block,
          contains('allow list:'),
          reason: 'collection queries must remain separately restricted',
        );
        expect(
          block,
          isNot(contains('allow read:')),
          reason: 'get and list must not share broad authorization',
        );
      }
    },
  );

  test('manual account history is immutable and owner scoped', () {
    final rules = File('firestore.rules').readAsStringSync();
    final start = rules.indexOf('match /account_entries/');
    expect(start, isNonNegative);
    final nextMatch = rules.indexOf('\n    match /', start + 1);
    final block = rules.substring(start, nextMatch);

    expect(block, contains('resource.data.userId == request.auth.uid'));
    expect(block, contains('request.resource.data.previousBalance is number'));
    expect(block, contains('request.resource.data.newBalance is number'));
    expect(block, contains('allow update, delete: if false'));
  });
}
