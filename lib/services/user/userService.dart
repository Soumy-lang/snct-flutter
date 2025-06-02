import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../models/user/userModel.dart';


class RechercheService {
  Future<List<dynamic>> fetchTrajets(Search trajetSchema) async {
final url = Uri.parse('http://localhost:4000/api/trajet');


  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(trajetSchema.toJson()),
  );

  if (response.statusCode == 200) {
   final List<dynamic> data = jsonDecode(response.body);
    return data; 
  } else {
    throw Exception("Erreur serveur : ${response.statusCode}");
  }
}
}
