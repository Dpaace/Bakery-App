import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bakey/Screen/userOrders.dart';
import 'package:flutter/material.dart';
import 'package:shake/shake.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

class Profilescreen extends StatefulWidget {
  const Profilescreen({super.key});

  @override
  State<Profilescreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {
  ShakeDetector? detector;

  @override
  void initState() {
    super.initState();
    detector = ShakeDetector.autoStart(
      onPhoneShake: () async {
        AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: 1,
            channelKey: 'basic_channel',
            title: "Log Out",
            body: "You are logged out!",
          ),
        );
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(
          context,
          LoginScreen.route,
        );
      },
    );
  }

  @override
  void dispose() {
    detector!.stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Profile"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, UserOrdersScreen.route);
              },
              child: const Text(
                "Your Orders",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                SharedPreferences pref = await SharedPreferences.getInstance();
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
                Navigator.pushReplacementNamed(context, LoginScreen.route);
              },
              child: const Text(
                "Log Out",
                style: TextStyle(fontSize: 20),
              ),
            ),
          )
        ],
      ),
    );
  }
}
