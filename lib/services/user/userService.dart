import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../models/user/userModel.dart';

class Recherhcedesti {
  Future<String> uservues(Search TrajetSchema) async {
    final url = Uri.parse('http://localhost:5000/trajet');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(TrajetSchema.toJson()),
    );

    if (response.statusCode == 200) {
       final data =jsonDecode(response.body);

      return data['token'];
    } else {
      return  "${response.statusCode}";
    }
  }
}
