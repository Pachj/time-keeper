import 'package:isar/isar.dart';

part 'work_entry.g.dart';

@Collection()
class WorkEntry {
  @Index()
  Id id = Isar.autoIncrement;
  late DateTime start;
  DateTime? end;
}
