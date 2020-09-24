import 'package:bytebank/models/contact.dart';

class Transaction {
  final String id;
  final double value;
  final Contact contact;

  Transaction(this.id, this.value, this.contact);

  @override
  String toString() {
    return "Transaction:{ id: $id, value: $value, contact: $contact }";
  }
}
