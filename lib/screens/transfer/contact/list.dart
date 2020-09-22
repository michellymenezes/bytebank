import 'package:bytebank/database/app_database.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/transfer/contact/form.dart';
import 'package:flutter/material.dart';

class ContactList extends StatelessWidget {
  final List<Contact> contacts = List();

  @override
  Widget build(BuildContext context) {
    // contacts.add(Contact(1, "Martha", 123456));
    // contacts.add(Contact(2, "Menezes", 789012));

    findAll().then((value) => contacts.addAll(value));

    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts"),
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final Contact contact = contacts[index];
          return _ContactItem(contact);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
                builder: (context) => ContactForm(),
              ))
              .then((newContact) =>
                  {print("Contact received: ${newContact.toString()}")});
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  final Contact contact;

  const _ContactItem(this.contact);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          "Martha",
          style: TextStyle(
            fontSize: 24.0,
          ),
        ),
        subtitle: Text(
          "1000",
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
