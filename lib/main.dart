import 'package:bytebank/http/http.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:bytebank/screens/transfer/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/contact.dart';

void main() async {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppConfig(),
      child: ByteBankApp(),
    ),
  );

  save(Transaction("0", 100, Contact(0, "Martha", 123456)))
  .then((transaction) => print("Transaction saved: ${transaction}"));
}

class AppConfig extends ChangeNotifier {
  bool _darkMode = false;

  bool get darkMode {
    return _darkMode;
  }

  void toggleDarkMode() {
    this._darkMode = !this._darkMode;
    print("DarkMode status: $_darkMode");
    notifyListeners();
  }
}

// Represents the Application
class ByteBankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appConfig = AppConfig();
    return Consumer<AppConfig>(
      builder: (context, appConfig, child) {
        return MaterialApp(
          theme: appConfig.darkMode
              ? ThemeData.dark()
              : ThemeData(
                  primaryColor: Colors.green[900],
                  accentColor: Colors.blueAccent[700],
                  buttonTheme: ButtonThemeData(
                      buttonColor: Colors.blueAccent[700],
                      textTheme: ButtonTextTheme.primary)),
          home: SafeArea(child: Dashboard()),
        );
      },
    );
  }
}
