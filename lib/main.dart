// import 'package:flutter/cupertino.dart';
import 'package:bytebank/screens/transfer/dashboard.dart';
import 'package:flutter/material.dart';
import 'database/dao/contact_dao.dart';

void main() {
  runApp(ByteBankApp());
  // createDatabase();
  // save(Contact(1, "Martha", 123456)).then((value) => print("Saved!"));
  final ContactDao _dao = ContactDao();
  _dao.findAll().then((contacts) => print("${contacts}"));
}

// Represents the Application
class ByteBankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Dashboard(),
      theme: ThemeData(
          primaryColor: Colors.green[900],
          accentColor: Colors.blueAccent[700],
          buttonTheme: ButtonThemeData(
              buttonColor: Colors.blueAccent[700],
              textTheme: ButtonTextTheme.primary)),
    );
  }
}
