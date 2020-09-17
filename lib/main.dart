// import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(ByteBankApp());

// Represents the Application
class ByteBankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TransferList(),
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
            onPressed: () => _createTransfer(context),
          )
        ],
      ),
    );
  }

  void _createTransfer(BuildContext context) {
    // Parse the values
    print("Pressed!");
    final int accountNumber = int.tryParse(_accountNumberFieldController.text);
    final double value = double.tryParse(_valueFieldController.text);

    if (accountNumber != null && value != null) {
      // Creates the transfer
      final createdTransfer = Transfer(value, accountNumber);
      debugPrint("$createdTransfer".toString());
      debugPrint("$createdTransfer");
      Navigator.pop(context, createdTransfer);
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
  final List<Transfer> _transfers = List();

  @override
  Widget build(BuildContext context) {

    _transfers.add(Transfer((100.0), 1001));
    _transfers.add(Transfer((100.0), 1001));
    _transfers.add(Transfer((100.0), 1001));
    _transfers.add(Transfer((100.0), 1001));
    _transfers.add(Transfer((100.0), 1001));

    return Scaffold(
      appBar: AppBar(
        title: Text("Transfers"),
      ),
      body: ListView.builder(itemCount: _transfers.length,
          itemBuilder: (context, index) {
        final transfer = _transfers[index];
        return TransferItem(transfer);
          }),


      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        // Add navigation future to the float button on the TransferList screen
        onPressed: () {
          final Future future = Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TransferForm(),
            ),
          );

          // Handle future value when returned
          future.then((receivedTransfer) {
            debugPrint("End of the future expression");
            debugPrint("$receivedTransfer");
            debugPrint("before: ${_transfers.length}");
            _transfers.add(receivedTransfer);
            debugPrint("after: ${_transfers.length}");
          });
        },
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
