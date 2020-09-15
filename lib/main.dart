// import 'package:flutter/cupertino.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Creating Transfers"),
      ),
      body: Column(
        children: [
          TextField(),
          TextField(),
          RaisedButton(),
        ],
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
}
