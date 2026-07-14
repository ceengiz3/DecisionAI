import 'package:decision_ai/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Home screen has Settings buttons', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: HomeScreen()),
    );
    await tester.pump();

    // AppBar icon + FAB = 2 settings icons
    expect(find.byIcon(Icons.settings), findsNWidgets(2));
  });
}
