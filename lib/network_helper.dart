import 'package:http/http.dart' as http;
import 'dart:convert';

class NetWorkHelper {
  final String url;

  NetWorkHelper({required this.url});

  Future<dynamic> GetData() async {
    http.Response response;
    response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      //error
      print(response.statusCode);
      return;
    }
  }
}
