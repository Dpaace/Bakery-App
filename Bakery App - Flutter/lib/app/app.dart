import 'package:bakey/Screen/login.dart';
import 'package:bakey/app/theme.dart';
import 'package:flutter/material.dart';

import 'routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required bool debugShowCheckedModeBanner,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Bakery',
      debugShowCheckedModeBanner: false,
      theme: getApplicationThemeData(),
      initialRoute: LoginScreen.route,
      routes: getAppRoutes,
    );
  }
}
