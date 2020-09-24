import "package:http/http.dart";
import "package:http_interceptor/http_interceptor.dart";

//Running  java -jar ~/Downloads/server.jar

Future<Response> findAll() async {
  Client client =
      HttpClientWithInterceptor.build(interceptors: [LoggingInterceptor()]);
  return client.get("http://192.168.1.100:8080/transactions");

}

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    print(data);
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    print((data.body));
    return data;
  }
}
