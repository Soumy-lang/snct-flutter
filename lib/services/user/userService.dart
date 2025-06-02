import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../models/user/userModel.dart';


class RechercheService {
  Future<List<dynamic>> uservues(Search trajetSchema) async {
  final url = Uri.parse('http://localhost:5000/api/trajet'); // adapte l'URL si besoin

  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(trajetSchema.toJson()),
  );

  if (response.statusCode == 200) {
   final List<dynamic> data = jsonDecode(response.body);
    return data; // tu reçois un objet "trajet", on le met dans une liste
  } else {
    throw Exception("Erreur serveur : ${response.statusCode}");
  }
}
}
