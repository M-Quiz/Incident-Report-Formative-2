import 'package:campus_care/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('sign in opens the campus feed and sign out ends the session',
      (tester) async {
    await tester.pumpWidget(const CampusCareApp());

    await tester.enterText(
      find.byType(TextFormField).at(0),
      'student@university.edu',
    );
    await tester.enterText(find.byType(TextFormField).at(1), 'campus1234');
    await tester.tap(find.text('Sign in'));
    await tester.pumpAndSettle();

    expect(find.text('Campus feed'), findsOneWidget);
    expect(find.text('Leaking tap in the north wing'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.person_outline));
    await tester.pumpAndSettle();
    expect(find.text('student'), findsOneWidget);
    expect(find.text('Active session'), findsOneWidget);

    await tester.tap(find.text('Sign out'));
    await tester.pumpAndSettle();
    expect(find.text('Sign in'), findsOneWidget);
  });
}
