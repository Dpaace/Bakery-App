import 'package:bakey/Screen/login.dart';
import 'package:bakey/Screen/register.dart';
import 'package:bakey/app/routes.dart';
import 'package:bakey/app/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Enter register", (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        title: 'User Bakery',
        debugShowCheckedModeBanner: false,
        theme: getApplicationThemeData(),
        initialRoute: Register.route,
        routes: getAppRoutes,
      ),
    );

    Finder txtFname = find.byKey(const ValueKey('txtFname'));
    await tester.enterText(txtFname, 'khadka');

    Finder txtLname = find.byKey(const ValueKey('txtLname'));
    await tester.enterText(txtLname, 'khadka');

    Finder txtPhone = find.byKey(const ValueKey('txtPhone'));
    await tester.enterText(txtPhone, '123456789');

    Finder txtEmail = find.byKey(const ValueKey('txtEmail'));
    await tester.enterText(txtEmail, 'khadkattest1111@gmail.com');

    Finder txtPassword = find.byKey(const ValueKey('txtPassword'));
    await tester.enterText(txtPassword, 'password');

    Finder btnRegister = find.byKey(const ValueKey('btnRegister'));
    await tester.tap(btnRegister);

    await tester.pumpAndSettle(const Duration(seconds: 3));
    // await tester.pumpAndSettle();
    // await tester.pump();
    // Finder login = find.text("Home");
    Finder login = find.byType(LoginScreen);
    expect(login, findsOneWidget);
  });
}
