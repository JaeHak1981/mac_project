import 'package:calendar_scheduler/database/drift_database.dart';
import 'package:calendar_scheduler/screen/home_screen.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

const DEFAULT_COLORS = [
  // 빨강
  'F44336',
  // 주황
  'FF9800',
  // 노랑
  'FFEB3B',
  // 초록
  'FCAF50',
  // 파랑
  '2196F3',
  // 남
  '3F51B5',
  // 보라
  '9C27B0',
];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();

  final dataBase = LocalDatabase();

  final color = await dataBase.getCategoryColors();

  if (color.isEmpty) {
    for (String hexCode in DEFAULT_COLORS) {
      await dataBase.createCategoryColor(
          CategoryColorsCompanion(hexCode: Value(hexCode)));
    }
  }

  runApp(MaterialApp(
    home: HomeScreen(),
    theme: ThemeData(fontFamily: 'NotoSans'),
  ));
}
