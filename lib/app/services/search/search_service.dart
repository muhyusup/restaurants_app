import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchService {
  Future<List<dynamic>> searchAPI(String searchTerm) async {
    final String apiUrl =
        'https://restaurant-api.dicoding.dev/search?q=$searchTerm';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData['restaurants'];
    } else {
      throw Exception('Failed to load data from API');
    }
  }
}
