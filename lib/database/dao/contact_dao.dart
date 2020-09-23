import 'package:bytebank/database/app_database.dart';
import 'package:bytebank/models/contact.dart';
import 'package:sqflite/sqflite.dart';

class ContactDao {
  static final String _tableName = "contacts";
  static final String _id = "id";
  static final String _name = "name";
  static final String _accountNumber = "account_number";

  static final String tableSql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_name TEXT, '
      '$_accountNumber INTEGER)';

  Future<int> save(Contact contact) async {
    Database db = await getDatabase();
    Map<String, dynamic> contactMap = _toMap(contact);
    return db.insert(_tableName, contactMap);
  }

  Map<String, dynamic> _toMap(Contact contact) {
    final Map<String, dynamic> contactMap = Map();
    contactMap[_name] = contact.name;
    contactMap[_accountNumber] = contact.accountNumber;
    return contactMap;
  }

  Future<List<Contact>> findAll() async {
    Database db = await getDatabase();
    List<Map<String, dynamic>> maps = await db.query(_tableName);
    return _toList(maps);
  }

  List<Contact> _toList(List<Map<String, dynamic>> maps) {
    final List<Contact> contacts = List();

    for (Map<String, dynamic> map in maps) {
      final Contact contact = Contact(
        map[_id],
        map[_name],
        map[_accountNumber],
      );
      contacts.add(contact);
    }
    return contacts;
  }
}
