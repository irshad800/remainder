// models/reminder_model.dart
class ReminderModel {
  final String day;
  final DateTime time;
  final String activity;

  ReminderModel(
      {required this.day, required this.time, required this.activity});
}
