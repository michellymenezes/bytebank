// import 'package:flutter/cupertino.dart';
import 'package:bytebank/database/app_database.dart';
import 'package:bytebank/screens/transfer/contact/form.dart';
import 'package:bytebank/screens/transfer/dashboard.dart';
import 'package:bytebank/screens/transfer/list.dart';
import 'package:flutter/material.dart';

import 'models/contact.dart';

void main() {
  runApp(ByteBankApp());
  // createDatabase();
  // save(Contact(1, "Martha", 123456)).then((value) => print("Saved!"));
  findAll().then((contacts) => print("${contacts}"));
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
