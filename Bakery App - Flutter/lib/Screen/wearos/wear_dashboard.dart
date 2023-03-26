import 'package:bakey/Screen/wearos/wear_login.dart';
import 'package:bakey/Screen/wearos/wear_orders.dart';
import 'package:flutter/material.dart';
import 'package:wear/wear.dart';

class WearOsDashboard extends StatefulWidget {
  const WearOsDashboard({super.key});
  static const String route = "wearOsDashboard";

  @override
  State<WearOsDashboard> createState() => _WearOsDashboardState();
}

class _WearOsDashboardState extends State<WearOsDashboard> {
  @override
  Widget build(BuildContext context) {
    return WatchShape(
      builder: (context, shape, child) {
        return AmbientMode(
          builder: (context, mode, child) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Dashboard"),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, WearOrdersScreen.route);
                      },
                      child: const Text("My Orders"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, WearOSLoginScreen.route);
                      },
                      child: const Text("Log Out"),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
