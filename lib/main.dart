import 'package:attendance_manager/gsheets.dart';
import 'package:attendance_manager/home.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized;
  await GSheetsAPI.init();

  runApp(const MyApp());

  // Request location permission

  if (await Geolocator.checkPermission() == LocationPermission.denied) {
    await Geolocator.requestPermission();
  }
  if (await Geolocator.isLocationServiceEnabled() == false) {
    await Geolocator.openLocationSettings();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CalendarControllerProvider(
      controller: EventController(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MarkMyAttendance',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const QRpage(),
      ),
    );
  }
}
