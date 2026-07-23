import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('MaterialApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: const Scaffold(
          body: Center(child: Text('Hello')),
        ),
      ),
    );

    expect(find.text('Hello'), findsOneWidget);
  });
}
