import 'dart:convert';
import 'package:http/http.dart' as http;

class LigneService {
  static const String apiUrl = "http://localhost:4000/api/lignes"; // À adapter en prod

  Future<List<Map<String, dynamic>>> fetchLignes() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List lignes = jsonDecode(response.body);
      return lignes.cast<Map<String, dynamic>>();
    } else {
      throw Exception("Erreur serveur : ${response.statusCode}");
    }
  }
}
