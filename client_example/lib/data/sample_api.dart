import 'dart:convert';
import 'package:http/http.dart' as http;

class SampleApi {
  SampleApi({required this.host});

  final String host;

  Future<String> getRoot() async {
    return (await _get('/') as String);
  }

  Future<String> getEcho() async {
    return (await _get('/echo/hoge') as String);
  }

  Future<Map<String, dynamic>> getJson() async {
    final response = await _get('/json');
    return jsonDecode(response);
  }

  Future<dynamic> _get(String path) async {
    final url = Uri.http(host, path);
    try {
      final response = await http.get(url);
      return response.body;
    } catch (e) {
      return e.toString();
    }
  }
}
