import 'dart:convert';

import 'package:bytebank/http/logging_interceptor.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

class TransactionWebClient {
  Future<List<Transaction>> findAll() async {
    Client client =
        HttpClientWithInterceptor.build(interceptors: [LoggingInterceptor()]);
    final Response response =
        await client.get("http://10.0.2.2:8080/transactions");
    final List<dynamic> decodedJson = jsonDecode(response.body);
    print("decodedJson $decodedJson");
    final List<Transaction> transactions = List();
    for (Map<String, dynamic> el in decodedJson) {
      final Transaction transaction = Transaction(
        el["id"],
        el["value"],
        Contact(
          0,
          el["contact"]["name"],
          el["contact"]["accountNumber"],
        ),
      );
      transactions.add(transaction);
    }
    return transactions;
  }

  Future<Transaction> save(Transaction transaction) async {
    final Map<String, dynamic> transactionMap = {
      "value": transaction.value,
      "contact": {
        "name": transaction.contact.name,
        "AccountNumber": transaction.contact.accountNumber
      }
    };

    final String body = jsonEncode(transactionMap);

    Client client =
        HttpClientWithInterceptor.build(interceptors: [LoggingInterceptor()]);

    final Response response = await client.post(
      "http://10.0.2.2:8080/transactions",
      headers: {"Content-type": "application/json", "password": "1000"},
      body: body,
    );

    Map<String, dynamic> json = jsonDecode(response.body);

    return Transaction(
      json["id"],
      json["value"],
      Contact(
        0,
        json["contact"]["name"],
        json["contact"]["accountNumber"],
      ),
    );
  }
}
