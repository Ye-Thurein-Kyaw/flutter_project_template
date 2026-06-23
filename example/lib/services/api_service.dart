import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://example.com';

  ApiService();
  Future<http.Response> get(String endpoint) async {
    final url = Uri.parse(baseUrl + endpoint);
    final response = await http.get(url);
    return _handleResponse(response);
  }
  Future<http.Response> post(String endpoint, Map<String, dynamic> body) async {
    final url = Uri.parse(baseUrl + endpoint);
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    return _handleResponse(response);
  }

  Future<http.Response> put(String endpoint, Map<String, dynamic> body) async {
    final url = Uri.parse(baseUrl + endpoint);
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    return _handleResponse(response);
  }
  Future<http.Response> delete(String endpoint) async {
    final url = Uri.parse(baseUrl + endpoint);
    final response = await http.delete(url);
    return _handleResponse(response);
  }

  Future<http.Response> uploadFile(String endpoint, File file, {String fieldName = 'file'}) async {
    final url = Uri.parse(baseUrl + endpoint);
    final request = http.MultipartRequest('POST', url);

    request.files.add(
      await http.MultipartFile.fromPath(fieldName, file.path),
    );

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    return _handleResponse(response);
  }

  http.Response _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response;
    } else {
      throw Exception('HTTP Error: False');
    }
  }
}
