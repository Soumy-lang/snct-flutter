import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OtpService {
  static const String baseUrl = "http://localhost:5000/api/otp";

  static Future<Map<String, dynamic>> postRequest(
    String endpoint, 
    Map<String, dynamic> body
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(body),
    );

    return {
      'status': response.statusCode,
      'body': json.decode(response.body)
    };
  }
}
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer votre email';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Email invalide';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer un mot de passe';
    }
    if (value.length < 6) {
      return 'Le mot de passe doit contenir au moins 6 caractères';
    }
    return null;
  }

  String? validateConfirmPassword(String? value, TextEditingController controller) {
    if (value == null || value.isEmpty) {
      return 'Veuillez confirmer le mot de passe';
    }
    if (value != controller.text) {
      return 'Les mots de passe ne correspondent pas';
    }
    return null;
  }
