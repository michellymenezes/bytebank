// import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(ByteBankApp());

// Represents the Application
class ByteBankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: TransferList()),
      theme: ThemeData(
        primaryColor: Colors.green[900],
        accentColor: Colors.blueAccent[700],
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blueAccent[700],
          textTheme: ButtonTextTheme.primary
        )
      ),);
  }
}

// Convert to stateful widget
class TransferForm extends StatefulWidget {
  // Create controllers
  @override
  _TransferFormState createState() => _TransferFormState();
}

class _TransferFormState extends State<TransferForm> {
  bool _isValueFieldValid = false;
  bool _isAccountFieldValid = false;
  bool _isValueFieldDirty = false;
  bool _isAccountFieldDirty = false;

  final TextEditingController _accountNumberFieldController =
  TextEditingController();

  final TextEditingController _valueFieldController = TextEditingController();

  @override
  initState() {
    super.initState();
    _accountNumberFieldController.addListener(() => _validateFields());
    _valueFieldController.addListener(() => _validateFields());
  }

  _validateFields() {
    setState(() {
      _isAccountFieldValid =
          int.tryParse(_accountNumberFieldController.text) != null;
      _isValueFieldValid = double.tryParse(_valueFieldController.text) != null;
    });
  }

  bool _isFormValid() {
    return _isValueFieldValid && _isAccountFieldValid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Creating Transfers"),
      ),
      // Avoid hiding the button by the keyboard
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Editor(
              controller: _accountNumberFieldController,
              label: "Account Number",
              hint: "0000",
              autofocus: true,
              onChanged: (value) => setState(() => _isAccountFieldDirty = true),
              hasError: _isAccountFieldDirty && !_isAccountFieldValid,
            ),
            Editor(
              controller: _valueFieldController,
              label: "Value",
              hint: "0.00",
              icon: Icons.monetization_on,
              onChanged: (value) => setState(() => _isValueFieldDirty = true),
              hasError: _isValueFieldDirty && !_isValueFieldValid,
            ),
            RaisedButton(
              child: Text("Confirm"),
              onPressed: _isFormValid() ? () => _createTransfer(context) : null,
            )
          ],
        ),
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

    // Dispose the controllers
    @override
    void dispose() {
      _accountNumberFieldController.dispose();
      _valueFieldController.dispose();
      super.dispose();
    }
  }
}

class Editor extends StatelessWidget {
  final String hint;
  final String label;
  final TextEditingController controller;
  final IconData icon;
  final bool autofocus;
  final bool hasError;
  final void Function(String) onChanged;

  const Editor({
    this.controller,
    this.label,
    this.hint,
    this.icon,
    this.onChanged,
    this.autofocus = false,
    this.hasError = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
      child: TextField(
        // Map values
        controller: controller,
        style: TextStyle(fontSize: 24.0),
        onChanged: onChanged,
        decoration: InputDecoration(
          icon: icon != null ? Icon(this.icon) : null,
          labelText: label,
          hintText: hint,
          focusedBorder: new OutlineInputBorder(
            borderSide:
            new BorderSide(color: hasError ? Colors.red : Colors.teal),
          ),
        ),
        keyboardType: TextInputType.number,
        autofocus: autofocus,
      ),
    );
  }
}

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
        title: Text("Transfers"),
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
