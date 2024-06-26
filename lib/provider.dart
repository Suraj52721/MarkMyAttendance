import 'dart:convert';
import 'package:attendance_manager/gsheets.dart';
import 'package:attendance_manager/locat.dart';
import 'package:device_uuid/device_uuid.dart';
import 'package:flutter_map_math/flutter_geo_math.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class ProviderPage {
  GeoLocate locat = GeoLocate();

  Future<Position> getLocation() async {
    Future<Position> position = locat.determinePosition();
    return position;
  }

  Future getTimeAPI() async {
    Position coor = await getLocation();
    final res = await http.get(Uri.parse(
        'https://timeapi.io/api/Time/current/coordinate?latitude=${coor.latitude}&longitude=${coor.longitude}'));
    final body = jsonDecode(res.body);
    return body;
  }

  Future<bool> validateTime() async {
    final timeAPI = await getTimeAPI();
    final defTime = await GSheetsAPI.getTime();
    final defTime2 = await GSheetsAPI.getTime2();
    List<int> time = [timeAPI['hour'], timeAPI['minute']];
    if ((time[0] >= defTime[0] && time[0] <= defTime[2]) ||
        (time[0] >= defTime2[0] && time[0] <= defTime2[2])) {
      if (((time[0] == defTime[0] && time[1] >= defTime[1]) ||
              (time[0] == defTime2[0] && time[1] >= defTime2[1])) ||
          ((time[0] == defTime[2] && time[1] <= defTime[3]) ||
              (time[0] == defTime2[2] && time[1] <= defTime2[3]) ||
              (time[0] > defTime[0] && time[0] < defTime[2]) ||
              (time[0] > defTime2[0] && time[0] < defTime2[2]))) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> validateMAC() async {
    String? mac = await DeviceUuid().getUUID();
    List<String> uid = await GSheetsAPI.getColumn();
    List<String> uid2 = await GSheetsAPI.getColumn2();

    if (uid.contains(mac) && uid2.contains(mac)) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> validateLocation() async {
    Position coor = await getLocation();
    List<double> pos = await GSheetsAPI.getLocate();

    double distance = FlutterMapMath().distanceBetween(
        coor.latitude, coor.longitude, pos[0], pos[1], "meters");

    if (distance <= 50.0) {
      return true;
    } else {
      return false;
    }
  }

  Future<String> finalValidation() async {
    bool time = await validateTime();
    bool mac = await validateMAC();
    bool location = await validateLocation();

    if (time == true && mac == true && location == true) {
      String? macid1 = await DeviceUuid().getUUID();
      String macid = macid1.toString();
      var time = await getTimeAPI();

      if (time['hour'] < 12) {
        time['hour'] = '0${time['hour']}';
        await GSheetsAPI.markAttendance(
            macid, '"${time['day']}-${time['month']}-${time['year']}"');
      } else {
        await GSheetsAPI.markAttendance2(
            macid, '"${time['day']}-${time['month']}-${time['year']}"');
      }
      //await GSheetsAPI.insertRow(macid, dateTime, location);

      return 'true';
    } else {
      if (time == false) {
        return 'Time Over';
      } else if (mac == false) {
        return 'Wrong Device';
      } else if (location == false) {
        return 'Out of Range';
      } else {
        return 'false';
      }
    }
  }
}
