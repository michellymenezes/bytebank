// Convert to stateful widget
import 'package:bytebank/components/editor.dart';
import 'package:bytebank/http/http.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:bytebank/models/transfer.dart';
import 'package:flutter/material.dart';

const _appBarTitle = "Creating Transfers";

const _labelValueField = "Value";
const _hintValueField = "0.00";

const _confirmButtonText = "Confirm";

class TransferForm extends StatefulWidget {
  final Contact contact;

  const TransferForm(this.contact);

  // Create controllers
  @override
  _TransferFormState createState() => _TransferFormState();
}

class _TransferFormState extends State<TransferForm> {
  bool _isValueFieldValid = false;
  bool _isValueFieldDirty = false;

  final TextEditingController _valueFieldController = TextEditingController();

  @override
  initState() {
    super.initState();
    _valueFieldController.addListener(() => _validateFields());
  }

  _validateFields() {
    setState(() {
      _isValueFieldValid = double.tryParse(_valueFieldController.text) != null;
    });
  }

  bool _isFormValid() {
    return _isValueFieldValid;
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
            Column(
              children: [
                Text(
                  widget.contact.name,
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    widget.contact.accountNumber.toString(),
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
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
    final double value = double.tryParse(_valueFieldController.text);

    if (value != null) {
      // Creates the transfer
      final transacation = Transaction("0", value, widget.contact);

      save(transacation).then((value) => Navigator.pop(context));
    } else {
      print("Invalid Input");
    }

    // Dispose the controllers
    @override
    void dispose() {
      _valueFieldController.dispose();
      super.dispose();
    }
  }
}
