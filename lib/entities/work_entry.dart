import 'package:isar/isar.dart';

part 'work_entry.g.dart';

@Collection()
class WorkEntry {
  Id id = Isar.autoIncrement;
  late DateTime start;
  DateTime? end;
}
