import 'package:bakey/Screen/home_screen.dart';
import 'package:bakey/Screen/login.dart';
import 'package:bakey/app/routes.dart';
import 'package:bakey/app/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets("Enter login credentials and login", (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        title: 'User Bakery',
        debugShowCheckedModeBanner: false,
        theme: getApplicationThemeData(),
        initialRoute: LoginScreen.route,
        routes: getAppRoutes,
      ),
    );

    Finder txtEmail = find.byKey(const ValueKey('txtEmail'));
    await tester.enterText(txtEmail, 'khadka@gmail.com');
    Finder txtPassword = find.byKey(const ValueKey('txtPassword'));
    await tester.enterText(txtPassword, 'password');
    Finder btnContinue = find.byKey(const ValueKey('btnLogin'));
    await tester.tap(btnContinue);

    await tester.pumpAndSettle(const Duration(seconds: 3));
    // await tester.pumpAndSettle();
    // await tester.pump();
    // Finder home = find.text("Home");
    Finder home = find.byType(GridHomeScreen);
    expect(home, findsOneWidget);
  });
}
