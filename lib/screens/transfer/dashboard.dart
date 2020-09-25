import 'package:bytebank/main.dart';
import 'package:bytebank/screens/transfer/list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'contact/list.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        actions: [
          Consumer<AppConfig>(builder: (context, appConfig, child) {
            return IconButton(
              icon: Icon(Icons.lightbulb_outline),
              onPressed: () => appConfig.toggleDarkMode(),
            );
          })
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset("images/bytebank_logo.png"),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _FeatureItem(
                  "Transfer",
                  Icons.monetization_on,
                  onClick: () => _showContactList(context),
                ),
                _FeatureItem(
                  "Transaction Feed",
                  Icons.description,
                  onClick: () => _showTransactionList(context),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _showContactList(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ContactList(),
      ),
    );
  }
}

void _showTransactionList(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => TransferList(),
    ),
  );
}

class _FeatureItem extends StatelessWidget {
  final String name;
  final IconData icon;
  final Function onClick;

  const _FeatureItem(this.name, this.icon, {@required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      // Wrap in Material
      child: Material(
        color: Theme.of(context).primaryColor,

        // Use InkWell
        child: InkWell(
          onTap: () => onClick(),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            height: 100,
            width: 150, // Remove the color property to apply the effect
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: 24.0,
                ),
                Text(
                  name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.00,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
