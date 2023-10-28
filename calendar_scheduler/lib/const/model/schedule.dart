import 'package:drift/drift.dart';

class Schedule extends Table {
  //PRIMARY KEY
  // id, content, date, statTime, endTime, colorId, createdAt,

  IntColumn get id => integer().autoIncrement()();

  TextColumn get content => text()();

  DateTimeColumn get date => dateTime()();

  IntColumn get startTime => integer()();

  IntColumn get endTime => integer()();

  IntColumn get colorId => integer()();

  DateTimeColumn get createdAt =>
      dateTime().clientDefault(() => DateTime.now())();
}
