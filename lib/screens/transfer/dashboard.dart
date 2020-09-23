import 'package:bytebank/main.dart';
import 'package:flutter/material.dart';

import 'contact/list.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset("images/bytebank_logo.png"),
          ),
          Row(
            children: [
              _FeatureItem("Transfer", Icons.monetization_on),
              _FeatureItem("Transaction Feed", Icons.description),
            ],
          )

        ],
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final String name;
  final IconData icon;

  const _FeatureItem(this.name, this.icon);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      // Wrap in Material
      child: Material(
        color: Theme.of(context).primaryColor,

        // Use InkWell
        child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ContactList(),
                ),
              );
            },
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
            )),
      ),
    );
  }
}
