import 'package:bytebank/database/dao/contact_dao.dart';
import "package:path/path.dart";
import "package:sqflite/sqflite.dart";


Future<Database> getDatabase() async {
  final String dbPath = await getDatabasesPath();
  final String path = join(dbPath, "bytebank.db");
  return openDatabase(
    path,
    version: 1,
    onCreate: (db, version) {
      print("onCreate!");
      db.execute(ContactDao.tableSql);
    },
    // onDowngrade: onDatabaseDowngradeDelete,
  );
}


