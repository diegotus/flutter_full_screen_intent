import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_full_screen_intent/flutter_full_screen_intent.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

@pragma('vm:entry-point')
void backgroundTask() async {
  await FlutterFullScreenIntent().openFullScreenWidget('/FullScreenTest');
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _fullScreenIntentPlugin = FlutterFullScreenIntent();

  Future<void> scheduleOpen() async {
    DateTime time = DateTime.now().add(const Duration(seconds: 10));
    int id = time.hour * 100 + time.minute;
    await AndroidAlarmManager.oneShotAt(time, id, backgroundTask);
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await _fullScreenIntentPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Plugin example app')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Running on: $_platformVersion\n'),
            ElevatedButton(
              onPressed: () => scheduleOpen(),
              child: Text('Schedule Open Full Screen Widget'),
            ),
          ],
        ),
      ),
      routes: {'/fullScreenTest': (context) => FullScreenTest()},
    );
  }
}

class FullScreenTest extends StatelessWidget {
  const FullScreenTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Full Screen Widget')),
      body: Center(child: Text('This is a full-screen Flutter widget!')),
    );
  }
}
