// views/reminder_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/remainder_model.dart';
import '../services/notification_service.dart';
import '../view_model/reminder_view_model.dart';

class ReminderScreen extends StatefulWidget {
  @override
  _ReminderScreenState createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  String? _selectedDay;
  TimeOfDay? _selectedTime;
  String? _selectedActivity;

  final List<String> _daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  final List<String> _activities = [
    'Wake up',
    'Go to gym',
    'Breakfast',
    'Meetings',
    'Lunch',
    'Quick nap',
    'Go to library',
    'Dinner',
    'Go to sleep'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reminder App')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Day of the week dropdown
            DropdownButtonFormField<String>(
              hint: Text("Select Day"),
              value: _selectedDay,
              items: _daysOfWeek.map((day) {
                return DropdownMenuItem(
                  value: day,
                  child: Text(day),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedDay = value;
                });
              },
            ),
            SizedBox(height: 16),
            // Time picker
            ListTile(
              title: Text(_selectedTime == null
                  ? 'Select Time'
                  : '${_selectedTime!.hour}:${_selectedTime!.minute}'),
              trailing: Icon(Icons.access_time),
              onTap: () async {
                final TimeOfDay? time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (time != null) {
                  setState(() {
                    _selectedTime = time;
                  });
                }
              },
            ),
            SizedBox(height: 16),
            // Activity dropdown
            DropdownButtonFormField<String>(
              hint: Text("Select Activity"),
              value: _selectedActivity,
              items: _activities.map((activity) {
                return DropdownMenuItem(
                  value: activity,
                  child: Text(activity),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedActivity = value;
                });
              },
            ),
            SizedBox(height: 24),
            // Submit button
            ElevatedButton(
              onPressed: _submitReminder,
              child: Text('Set Reminder'),
            ),
          ],
        ),
      ),
    );
  }

  void _submitReminder() {
    if (_selectedDay != null &&
        _selectedTime != null &&
        _selectedActivity != null) {
      final reminder = ReminderModel(
        day: _selectedDay!,
        time: DateTime(2024, 1, 1, _selectedTime!.hour,
            _selectedTime!.minute), // Placeholder date
        activity: _selectedActivity!,
      );

      Provider.of<ReminderViewModel>(context, listen: false)
          .addReminder(reminder);

      NotificationService().scheduleNotification(
        DateTime.now().millisecondsSinceEpoch,
        reminder.time,
        'Reminder',
        '${reminder.activity} at ${reminder.time.hour}:${reminder.time.minute}',
      );

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Reminder set for ${reminder.activity}!')));
    }
  }
}
