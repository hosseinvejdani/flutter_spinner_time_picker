import 'package:flutter/material.dart';
import 'package:flutter_spinner_time_picker/flutter_spinner_time_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Time Picker Example',
      darkTheme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TimeOfDay selectedTime = TimeOfDay.now();
  Duration selectedDuration = const Duration(hours: 1, minutes: 20, seconds: 5);

  void _showTimePicker() async {
    final pickedTime = await showSpinnerTimePicker(
      context,
      initTime: selectedTime,
      is24HourFormat: false,
    );

    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  void _showDurationPicker() async {
    final pickedDuration = await showSpinnerDurationPicker(
      context,
      initDuration: selectedDuration,
    );

    if (pickedDuration != null) {
      setState(() {
        selectedDuration = pickedDuration;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Time Picker Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Selected Time:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              '${selectedTime.hour}:${selectedTime.minute.toString().padLeft(2, '0')}',
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: _showTimePicker,
              child: const Text('Pick a Time'),
            ),
            const SizedBox(height: 50),
            const Text(
              'Selected Duration:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              '${selectedDuration.inHours}:${selectedDuration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(selectedDuration.inSeconds.remainder(60).toString().padLeft(2, '0'))}',
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: _showDurationPicker,
              child: const Text('Pick a Duration'),
            ),
          ],
        ),
      ),
    );
  }
}
