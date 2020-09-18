import 'package:bytebank/models/transfer.dart';
import 'package:bytebank/screens/transfer/form.dart';
import 'package:flutter/material.dart';

const _transferListTitle = "Transfers";

class TransferList extends StatefulWidget {
  final List<Transfer> _transfers = List();

  @override
  _TransferListState createState() => _TransferListState();
}

class _TransferListState extends State<TransferList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_transferListTitle),
      ),
      body: ListView.builder(
          itemCount: widget._transfers.length,
          itemBuilder: (context, index) {
            final transfer = widget._transfers[index];
            return TransferItem(transfer);
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        // Add navigation future to the float button on the TransferList screen
        onPressed: () {
          final Future future = Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TransferForm(),
            ),
          );

          // Handle future value when returned
          future.then((receivedTransfer) {
            debugPrint("End of the future expression");
            // Check for null values
            if (receivedTransfer != null) {
              debugPrint("$receivedTransfer");
              // Refresh screen - rerun Widget
              setState(() {
                widget._transfers.add(receivedTransfer);
              });
            }
          });
        },
      ),
    );
  }
}
