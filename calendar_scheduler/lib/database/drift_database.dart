import 'dart:io';

import 'package:calendar_scheduler/const/model/category_color.dart';
import 'package:calendar_scheduler/const/model/schedule.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'drift_database.g.dart';

@DriftDatabase(tables: [
  Schedules,
  CategoryColors,
])
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(_openConnection());

  Future<int> createSchedule(SchedulesCompanion data)=> into(schedules).insert(data);

  Future<int> createCategoryColor(CategoryColorsCompanion data) => into(categoryColors).insert(data);

  Future<List<CategoryColor>> getCategoryColors()=>select(categoryColors).get();

  @override
  // TODO: implement schemaVersion
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbDatabase = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbDatabase.path, 'sq.lite'));
    return NativeDatabase(file);
  });
}
