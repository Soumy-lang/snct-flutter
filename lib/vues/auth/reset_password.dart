import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snct_app/services/otp.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final controllerPassword = TextEditingController();
  final controllerConfirmPassword = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  String? email;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadEmail();
  }

  Future<void> _loadEmail() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('reset_email');
    });
  }

  @override
  void dispose() {
    controllerPassword.dispose();
    controllerConfirmPassword.dispose();
    super.dispose();
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez confirmer le mot de passe';
    }
    if (value != controllerPassword.text) {
      return 'Les mots de passe ne correspondent pas';
    }
    return null;
  }

  Future<void> _resetPassword() async {
    if (_formKey.currentState!.validate() && email != null) {
      setState(() {
        _isLoading = true;
        errorMessage = null;
      });
      
      try {
        final response = await OtpService.postRequest(
          'reset-password', 
          {
            'email': email!,
            'newPassword': controllerPassword.text.trim()
          }
        );

        if (response['status'] == 200) {
          // Nettoyer les SharedPreferences
          final prefs = await SharedPreferences.getInstance();
          await prefs.remove('reset_email');
          
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Mot de passe réinitialisé avec succès!')),
          );
          Navigator.popUntil(context, (route) => route.isFirst);
        } else {
          setState(() {
            errorMessage = response['body']['message'] ?? "Erreur inconnue";
          });
        }
      } catch (e) {
        setState(() {
          errorMessage = "Erreur de connexion au serveur";
        });
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Column(
                children: <Widget>[
                  const SizedBox(height: 60.0),
                  const Text(
                    "Nouveau mot de passe",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Créez un nouveau mot de passe sécurisé",
                    style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                  ),
                  if (errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                ],
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: controllerPassword,
                      validator: validatePassword,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        hintText: "Nouveau mot de passe",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: const Color.fromARGB(255, 39, 176, 142).withOpacity(0.1),
                        filled: true,
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword 
                              ? Icons.visibility_off 
                              : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() => _obscurePassword = !_obscurePassword);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: controllerConfirmPassword,
                      validator: validateConfirmPassword,
                      obscureText: _obscureConfirmPassword,
                      decoration: InputDecoration(
                        hintText: "Confirmer le mot de passe",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: const Color.fromARGB(255, 39, 176, 142).withOpacity(0.1),
                        filled: true,
                        prefixIcon: const Icon(Icons.lock_reset),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirmPassword 
                              ? Icons.visibility_off 
                              : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() => _obscureConfirmPassword = !_obscureConfirmPassword);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: _isLoading ? null : _resetPassword,
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              "Réinitialiser",
                              style: TextStyle(fontSize: 20, color: Colors.white),
                            ),
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        minimumSize: const Size(double.infinity, 50),
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        backgroundColor: const Color.fromARGB(255, 39, 176, 142),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Annuler",
                      style: TextStyle(color: Colors.teal),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}