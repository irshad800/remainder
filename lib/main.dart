import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remainder/screens/remainder_screen.dart';
import 'package:remainder/services/notification_service.dart';
import 'package:remainder/view_model/reminder_view_model.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the timezone database
  tz.initializeTimeZones();

  // Initialize the NotificationService
  NotificationService notificationService = NotificationService();

  runApp(
    ChangeNotifierProvider(
      create: (_) => ReminderViewModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reminder App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ReminderScreen(),
    );
  }
}
