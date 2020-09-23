import 'package:bytebank/database/app_database.dart';
import 'package:bytebank/models/contact.dart';
import 'package:sqflite/sqflite.dart';

class ContactDao {
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
}