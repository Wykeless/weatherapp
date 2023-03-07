import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class NetworkHelper {
  final String url;

  NetworkHelper({required this.url});

  Future getData() async {
    Uri uri = Uri.parse(url);

    http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      String data = response.body;

      return jsonDecode(data);
    } else {
      log(response.statusCode.toString());
    }
  }
}
