import 'package:attendance_manager/gsheets.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:device_uuid/device_uuid.dart';
import 'package:flutter/material.dart';

class ViewAttendance extends StatefulWidget {
  ViewAttendance({Key? key}) : super(key: key);

  @override
  _ViewAttendanceState createState() => _ViewAttendanceState();
}

class _ViewAttendanceState extends State<ViewAttendance> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async{
            final uid = await DeviceUuid().getUUID();

            Map attend2 = await GSheetsAPI.viewAttendance2(uid);
            for (var element in attend2.entries) {
              if (element.value == "0.5") {
                var date = element.key.split('"')[1];
              date = date.toString().split('-');
              final event = CalendarEventData(
    date: DateTime(int.parse(date[2]), int.parse(date[1]), int.parse(date[0])),
    title: "Evening",
    color: Colors.red
);
CalendarControllerProvider.of(context).controller.add(event);
            }}

            Map attend = await GSheetsAPI.viewAttendance(uid);
            for (var element in attend.entries) {
              if (element.value == "0.5") {
                var date = element.key.split('"')[1];
              date = date.toString().split('-');
              final event = CalendarEventData(
    date: DateTime(int.parse(date[2]), int.parse(date[1]), int.parse(date[0])),
    title: "Morning",
    color: Colors.blue
);
CalendarControllerProvider.of(context).controller.add(event);
            }}

            
            print(attend);
            setState(() {
              

            });
          },
          child: const Icon(Icons.refresh),
        ),
        body: MonthView(

        ),
       ),
    );
  }
}