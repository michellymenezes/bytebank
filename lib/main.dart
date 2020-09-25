import 'package:bytebank/screens/transfer/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppConfig(),
      child: ByteBankApp(),
    ),
  );
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
