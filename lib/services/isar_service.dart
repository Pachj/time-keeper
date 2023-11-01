import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:time_keeper/entities/work_entry.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = openDB();
  }

  Future<int> saveWorkEntry(WorkEntry workEntry) async {
    final isarDB = await db;
    return isarDB.writeTxnSync<int>(() => isarDB.workEntrys.putSync(workEntry));
  }

  Future<void> setActualEndOnWorkEntry(int id) async {
    final isarDB = await db;
    final WorkEntry? lastWorkEntry =
        await isarDB.workEntrys.where().idEqualTo(id).findFirst();
    if (lastWorkEntry != null) {
      lastWorkEntry.end = DateTime.now();
      isarDB.writeTxnSync(() => isarDB.workEntrys.putSync(lastWorkEntry));
    }
  }

  Future<WorkEntry?> getWorkEntry(int id) async {
    final isarDB = await db;
    return isarDB.workEntrys.getSync(id);
  }

  Future<Isar> openDB() async {
    // create new DB if no one exists
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open(
        [WorkEntrySchema],
        directory: dir.path,
        inspector: true,
      );
    }

    return Future.value(Isar.getInstance());
  }
}
