import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../models/user/TrajetModel.dart';

class TrajetService {
  Future<List<TrajetModel>> fetchTrajets() async {
    final response = await http.get(Uri.parse('http://localhost:4000/api/trajets'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => TrajetModel.fromJson(json)).toList();
    } else {
      throw Exception('Erreur de chargement des trajets');
    }
  }
}
