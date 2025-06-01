import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  static const _storage = FlutterSecureStorage();
  static const _apiUrl = "http://localhost:5000/api/auth";

static Future<bool> register(String email, String password) async {
  try {
    final response = await http.post(
      Uri.parse("$_apiUrl/register"), 
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    print("Status Code: ${response.statusCode}"); 
    print("Response Body: ${response.body}"); 

    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception("Erreur: ${response.body}");
    }
  } catch (e) {
    print("Erreur d'inscription: $e"); 

    return false;
  }
}
  static Future<bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse("$_apiUrl/login"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    
    if (response.statusCode == 200) {
      final token = jsonDecode(response.body)['token'];
      await _storage.write(key: 'auth_token', value: token);
      return true;
    }
    return false;
  }

  static Future<void> logout() async {
    await _storage.delete(key: 'auth_token');
  }

  static Future<bool> isLoggedIn() async {
    return await _storage.read(key: 'auth_token') != null;
  }
}
String? validateEmail(String? value) {
  const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
      r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
      r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
      r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
      r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
      r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
      r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
  final regex = RegExp(pattern);

  return value!.isNotEmpty && !regex.hasMatch(value) || value!.isEmpty
      ? 'Entre un email valide'
      : null;
}

String? validatePassword(String? value) {
  RegExp regex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer un mot de passe';
    }
    if (value.length < 6) {
      return 'Le mot de passe doit contenir au moins 6 caractères';
    }    
  return value!.isNotEmpty && !regex.hasMatch(value)
      ? 'Mot de passe incorrect'
      : null;
}

