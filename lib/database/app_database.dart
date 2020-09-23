import 'package:bytebank/models/contact.dart';
import "package:path/path.dart";
import "package:sqflite/sqflite.dart";

Future<Database> createDatabase() async {
  final String dbPath = await getDatabasesPath();
  final String path = join(dbPath, "bytebank.db");
  return openDatabase(
    path,
    version: 1,
    onCreate: (db, version) {
      print("onCreate!");
      db.execute('CREATE TABLE contacts('
          'id INTEGER PRIMARY KEY, '
          'name TEXT, '
          'account_number INTEGER)');
    },
    // onDowngrade: onDatabaseDowngradeDelete,
  );
}


