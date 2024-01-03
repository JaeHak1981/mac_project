import 'package:calendar_scheduler/database/drift_database.dart';
import 'package:calendar_scheduler/screen/home_screen.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';

const DEFUALT_COLORS = [
  'F44336', //빨강
  'FF9800', //주황
  'FFFB3B', //노랑
  'FCAF50', //초록
  '2196F3', //파랑
  '3F51B5', //남색
  '9C27B0', //보라
];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();

  final database = LocalDatabase();

  GetIt.I.registerSingleton<LocalDatabase>(database);

  final colors = await database.getCategoryColors();
  if (colors.isEmpty) {
    for (String hexCode in DEFUALT_COLORS) {
      await database.createCategoryColor(
        CategoryColorsCompanion(
          hexCode: Value(hexCode),
        ),
      );
    }
  }
  runApp(MaterialApp(
    theme: ThemeData(fontFamily: 'NotoScans'),
    home: HomeScreen(),
  ));
}
