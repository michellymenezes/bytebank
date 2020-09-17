// import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(ByteBankApp());

// Represents the Application
class ByteBankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TransferForm(),
    );
  }
}

class TransferForm extends StatelessWidget {
  // Create controllers
  final TextEditingController _accountNumberFieldController =
      TextEditingController();
  final TextEditingController _valueFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Creating Transfers"),
      ),
      body: Column(
        children: [
          Editor(controller: _accountNumberFieldController, label: "Account Number", hint: "0000",),
          Editor(controller: _valueFieldController, label: "Value", hint: "0.00", icon: Icons.monetization_on),
          RaisedButton(
            child: Text("Confirm"),
            onPressed: () => _createTransfer(),
          )
        ],
      ),
    );
  }

  void _createTransfer() {
    // Parse the values
    print("Pressed!");
    final int accountNumber = int.tryParse(_accountNumberFieldController.text);
    final double value = double.tryParse(_valueFieldController.text);

    if (accountNumber != null && value != null) {
      // Creates the transfer
      final createdTransfer = Transfer(value, accountNumber);
      debugPrint("$createdTransfer".toString());
    } else {
      print("Invalid Input");
    }
  }
}


class Editor extends StatelessWidget {
  final String hint;
  final String label;
  final TextEditingController controller;
  final IconData icon;

  const Editor({this.controller, this.label, this.hint, this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
      child: TextField(
// Map values
        controller: controller,
        style: TextStyle(fontSize: 24.0),
        decoration: InputDecoration(
            icon: icon != null ? Icon(icon) : null , labelText: label, hintText: hint),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

class TransferList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transfers"),
      ),
      body: Column(
        children: [
          TransferItem(Transfer(100, 1000)),
          TransferItem(Transfer(200, 2000)),
          TransferItem(Transfer(300, 3000)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: null,
      ),
    );
  }
}

class TransferItem extends StatelessWidget {
  final Transfer _transfer; //the _ makes the property private

  TransferItem(this._transfer);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(_transfer.value.toString()),
        subtitle: Text(_transfer.accountNumber.toString()),
      ),
    );
  }
}

class Transfer {
  final double value;
  final int accountNumber;

  Transfer(this.value, this.accountNumber);

  // Override toString implementation
  @override
  String toString() {
    return "Transfer value: $value, Account number: $accountNumber";
  }
}
