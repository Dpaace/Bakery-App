import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

import 'adminAddProductScreen.dart';
import 'adminMenu.dart';
import 'allAdminProducts.dart';

class AdminDashBoard extends StatefulWidget {
  const AdminDashBoard({super.key});

  static const String route = "adminDashBoard";

  @override
  State<AdminDashBoard> createState() => _AdminDashBoardState();
}

class _AdminDashBoardState extends State<AdminDashBoard> {
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
    const AllAdminProductsScreen(),
    const AdminAddProductScreen(),
    const AdminMenuScreen(),
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
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Add Product',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Menu',
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
