import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bakey/Screen/adminLogin.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'adminOrdersScreen.dart';

class AdminMenuScreen extends StatefulWidget {
  const AdminMenuScreen({super.key});

  static const String route = "adminMenuScreen";

  @override
  State<AdminMenuScreen> createState() => _AdminMenuScreenState();
}

class _AdminMenuScreenState extends State<AdminMenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Menu"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, AdminOrdersScreen.route);
                },
                child: const Text(
                  "Total Orders",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  await pref.clear();
                  AwesomeNotifications().createNotification(
                    content: NotificationContent(
                      id: 1,
                      channelKey: 'basic_channel',
                      title: "Log Out",
                      body: "You are logged out of your account!",
                    ),
                  );
                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacementNamed(
                      context, AdminLoginScreen.route);
                },
                child: const Text(
                  "Log Out",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
