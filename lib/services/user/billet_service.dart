import 'dart:convert';
import 'package:http/http.dart' as http;

class BilletService {
  static const String apiUrl = 'http://localhost:5000/api/billets';

  Future<void> enregistrerBillet(Map<String, dynamic> billetData) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(billetData),
    );

    if (response.statusCode != 201) {
      throw Exception('Erreur serveur: ${response.body}');
    }
  }

  Future<List<Map<String, dynamic>>> getBillets(String email) async {
    final response = await http.get(
      Uri.parse('$apiUrl?email=$email'),
    );

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(jsonDecode(response.body));
    } else {
      throw Exception('Erreur récupération billets');
    }
  }
}
