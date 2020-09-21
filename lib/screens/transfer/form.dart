// Convert to stateful widget
import 'package:bytebank/components/editor.dart';
import 'package:bytebank/models/transfer.dart';
import 'package:flutter/material.dart';

const _appBarTitle = "Creating Transfers";

const _labelAccountField = "Account Number";
const _hintAccountField = "0000";

const _labelValueField = "Value";
const _hintValueField = "0.00";

const _confirmButtonText = "Confirm";

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
        title: Text(_appBarTitle),
      ),
      // Avoid hiding the button by the keyboard
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Editor(
              controller: _accountNumberFieldController,
              label: _labelAccountField,
              hint: _hintAccountField,
              autofocus: true,
              onChanged: (value) => setState(() => _isAccountFieldDirty = true),
              hasError: _isAccountFieldDirty && !_isAccountFieldValid,
            ),
            Editor(
              controller: _valueFieldController,
              label: _labelValueField,
              hint: _hintValueField,
              icon: Icons.monetization_on,
              onChanged: (value) => setState(() => _isValueFieldDirty = true),
              hasError: _isValueFieldDirty && !_isValueFieldValid,
            ),
            RaisedButton(
              child: Text(_confirmButtonText),
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
