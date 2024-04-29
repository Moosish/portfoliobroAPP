import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://your-cloud-run-url.a.run.app';

  Future<List<dynamic>> fetchPredictions(String ticker) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/predict?ticker=$ticker'));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load predictions');
      }
    } catch (e) {
      throw Exception('Failed to load predictions: $e');
    }
  }
}
