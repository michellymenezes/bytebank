// import 'package:flutter/cupertino.dart';
import 'package:bytebank/screens/transfer/dashboard.dart';
import 'package:bytebank/screens/transfer/list.dart';
import 'package:flutter/material.dart';

void main() => runApp(ByteBankApp());

// Represents the Application
class ByteBankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ContactForm(),
      theme: ThemeData(
          primaryColor: Colors.green[900],
          accentColor: Colors.blueAccent[700],
          buttonTheme: ButtonThemeData(
              buttonColor: Colors.blueAccent[700],
              textTheme: ButtonTextTheme.primary)),
    );
  }
}

class ContactForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Contact"),
      ),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: "Full Name",
            ),
            style: TextStyle(fontSize: 24.0),
          ),
          TextField(
            decoration: InputDecoration(
              labelText: "Account Number",
            ),
            style: TextStyle(fontSize: 24.0),
            keyboardType: TextInputType.number,
          ),
          RaisedButton(
            child: Text("Create"),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
