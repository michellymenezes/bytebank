import 'package:bytebank/models/contact.dart';
import "package:path/path.dart";
import "package:sqflite/sqflite.dart";

Future<Database> createDatabase() {
  return getDatabasesPath().then((dbPath) {
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
    );
  });
}

Future<int> save(Contact contact) {
  return createDatabase().then((db) {
    // final json = {"id": "my_id", "bar": 3};

    final Map<String, dynamic> contactMap = Map();
    contactMap['id'] = contact.id;
    contactMap['name'] = contact.name;
    contactMap['account_number'] = contact.accountNumber;
    return db.insert('contacts', contactMap);
  });
}
