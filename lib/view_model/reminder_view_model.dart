// viewmodels/reminder_viewmodel.dart
import 'package:flutter/material.dart';

import '../models/remainder_model.dart';

class ReminderViewModel with ChangeNotifier {
  List<ReminderModel> _reminders = [];

  List<ReminderModel> get reminders => _reminders;

  void addReminder(ReminderModel reminder) {
    _reminders.add(reminder);
    notifyListeners();
  }

  void removeReminder(ReminderModel reminder) {
    _reminders.remove(reminder);
    notifyListeners();
  }
}
