import "package:http/http.dart";

//Running  java -jar ~/Downloads/server.jar

void findAll() {
  get("http://192.168.1.100:8080/transactions")
      .then((value) => print("Values: ${value.body}"));
}