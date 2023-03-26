import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bakey/state/objectbox_state.dart';
import 'package:flutter/material.dart';

import 'app/app.dart';
import 'helper/objectbox.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // create an object for ObjectBoxInstance
  ObjectBoxState.objectBoxInstance = await ObjectBoxInstance.init();
  AwesomeNotifications().initialize(
    'resource://drawable/launcher',
    [
      NotificationChannel(
        channelGroupKey: "basic_channel_group",
        channelKey: 'basic_channel',
        channelName: "Basic notifications",
        channelDescription: "Notification channel for basic test",
        defaultColor: const Color(0xFF9D50DD),
        importance: NotificationImportance.Max,
        ledColor: Colors.white,
        channelShowBadge: true,
      )
    ],
  );
  runApp(
    const MyApp(
      debugShowCheckedModeBanner: false,
    ),
  );
}
