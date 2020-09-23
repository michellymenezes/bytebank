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

Future<int> save(Contact contact) async {
  Database db = await createDatabase();
  final Map<String, dynamic> contactMap = Map();
  contactMap['name'] = contact.name;
  contactMap['account_number'] = contact.accountNumber;
  return db.insert('contacts', contactMap);
}

Future<List<Contact>> findAll() async {
  Database db = await createDatabase();
  List<Map<String, dynamic>> maps = await db.query("contacts");
  final List<Contact> contacts = List();

  for (Map<String, dynamic> map in maps) {
    final Contact contact = Contact(
      map["id"],
      map["name"],
      map["account_number"],
    );
    contacts.add(contact);
  }
  return contacts;
}
