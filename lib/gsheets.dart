import 'package:gsheets/gsheets.dart';
import 'api_key.dart';

class GSheetsAPI {
  _credentials = ApiKey.credentials;

  /// Your spreadsheet id
  ///
  /// It can be found in the link to your spreadsheet -
  /// link looks like so https://docs.google.com/spreadsheets/d/YOUR_SPREADSHEET_ID/edit#gid=0
  /// [YOUR_SPREADSHEE T_ID] in the path is the id your need
  static const _spreadsheetId = '194L1_uU3ScYCFNjtlut3-hIHe_AHF3-2N2GFgicQzE0';
  static final _gsheets = GSheets(_credentials);
  static late Worksheet _worksheet;
  static late Worksheet _worksheet2;

  static Future<void> init() async {
    final ss = await _gsheets.spreadsheet(_spreadsheetId);
    _worksheet = ss.worksheetByTitle('Sheet1')!;
    _worksheet2 = ss.worksheetByTitle('Sheet2')!;
  }

  static Future<void> insertRow(
      String uniqueId, String time, String location) async {
    List<String> values = [uniqueId, time, location];
    await _worksheet.values.appendRow(values);
  }

  static Future<List<String>> getColumn() async {
    final column = await _worksheet.values.column(2);
    return column;
  }

  static Future<List<String>> getColumn2() async {
    final column = await _worksheet2.values.column(2);
    return column;
  }

  static Future<List<double>> getLocate() async {
    final lat = await _worksheet.cells.cell(row: 1, column: 2);
    final long = await _worksheet.cells.cell(row: 1, column: 3);
    return [double.parse(lat.value), double.parse(long.value)];
  }

  static Future<List<int>> getTime() async {
    final hours = await _worksheet.cells.cell(row: 1, column: 6);
    final hours2 = await _worksheet.cells.cell(row: 1, column: 7);
    final minutes = await _worksheet.cells.cell(row: 1, column: 8);
    final minutes2 = await _worksheet.cells.cell(row: 1, column: 9);
    return [
      int.parse(hours.value),
      int.parse(hours2.value),
      int.parse(minutes.value),
      int.parse(minutes2.value)
    ];
  }

  static Future<List<int>> getTime2() async {
    final hours = await _worksheet2.cells.cell(row: 1, column: 6);
    final hours2 = await _worksheet2.cells.cell(row: 1, column: 7);
    final minutes = await _worksheet2.cells.cell(row: 1, column: 8);
    final minutes2 = await _worksheet2.cells.cell(row: 1, column: 9);
    return [
      int.parse(hours.value),
      int.parse(hours2.value),
      int.parse(minutes.value),
      int.parse(minutes2.value)
    ];
  }

  static Future<void> markAttendance(String uniqueId, String date) async {
    //get row id of the uniqueId
    final col1 = await _worksheet.values.column(2);

    final row = col1.indexOf(uniqueId) + 1;

    final row1 = await _worksheet.values.row(2);

    final column = row1.indexOf(date);

    await _worksheet.values.insertValue(0.5, column: column + 1, row: row);
  }

  static Future<void> markAttendance2(String uniqueId, String date) async {
    //get row id of the uniqueId
    final col1 = await _worksheet2.values.column(2);

    final row = col1.indexOf(uniqueId) + 1;

    final row1 = await _worksheet2.values.row(2);

    final column = row1.indexOf(date);

    await _worksheet2.values.insertValue(0.5, column: column + 1, row: row);
  }
}
