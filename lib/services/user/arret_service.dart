import 'dart:convert';
import 'package:http/http.dart' as http;

class ArretService {
  static const String apiUrl = "http://localhost:5000/api/arrets";

  Future<List<Map<String, dynamic>>> fetchArrets() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List arrets = jsonDecode(response.body);
      return arrets.cast<Map<String, dynamic>>();
    } else {
      throw Exception("Erreur serveur : ${response.statusCode}");
    }
  }


Future<List<Map<String, dynamic>>> fetchArretsByLigneName(String ligneName) async {
  final response = await http.get(Uri.parse('http://localhost:5000/api/arrets/ligne/$ligneName'));

  if (response.statusCode == 200) {
    return List<Map<String, dynamic>>.from(jsonDecode(response.body));
  } else {
    throw Exception("Erreur lors de la récupération des arrêts de la ligne $ligneName");
  }
}


}
