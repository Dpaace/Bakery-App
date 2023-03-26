import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bakey/Screen/home_screen.dart';
import 'package:flutter/material.dart';

import 'cartscreen.dart';
import 'profilescreen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  static const String route = "dashboardScreen";

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  _checkNotificationEnabled() {
    AwesomeNotifications().isNotificationAllowed().then(
      (isAllowed) {
        if (!isAllowed) {
          AwesomeNotifications().requestPermissionToSendNotifications();
        }
      },
    );
  }

  @override
  void initState() {
    _checkNotificationEnabled();
    super.initState();
  }

  String searchValue = '';
  int _selectedIndex = 0;
  List<Widget> lstBottomScreen = [
    // const HomeScreen(),
    const GridHomeScreen(),
    const Cartscreen(),
    const Profilescreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // title: const Text('Homepage'),
      //   backgroundColor: const Color.fromARGB(255, 71, 160, 232),
      //   centerTitle: true,
      // ),
      body: lstBottomScreen[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 249, 130, 33),
        selectedItemColor: Colors.yellowAccent,
        unselectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
