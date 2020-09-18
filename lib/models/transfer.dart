import 'package:flutter/material.dart';

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
