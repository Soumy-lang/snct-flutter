import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snct_app/services/otp.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final _formKey = GlobalKey<FormState>();
  final controllerOtp = TextEditingController();
  bool _isLoading = false;
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
    controllerOtp.dispose();
    super.dispose();
  }

  String? validateOtp(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer le code';
    }
    if (!RegExp(r'^\d{6}$').hasMatch(value)) {
      return 'Code invalide (6 chiffres)';
    }
    return null;
  }

  Future<void> _verifyOTP() async {
    if (_formKey.currentState!.validate() && email != null) {
      setState(() {
        _isLoading = true;
        errorMessage = null;
      });
      
      try {
        final response = await OtpService.postRequest(
          'verify', 
          {
            'email': email!,
            'otp': controllerOtp.text.trim()
          }
        );

        if (response['status'] == 200) {
          Navigator.pushNamed(context, '/reset-password');
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

  Future<void> _resendOTP() async {
    if (email != null) {
      setState(() => _isLoading = true);
      
      try {
        final response = await OtpService.postRequest(
          'otp/send', 
          {'email': email!}
        );

        if (response['status'] != 200) {
          setState(() {
            errorMessage = "Échec de l'envoi du code";
          });
        }
      } catch (e) {
        setState(() {
          errorMessage = "Erreur de connexion";
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
                    "Vérification",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    email != null 
                      ? "Code envoyé à $email" 
                      : "Chargement...",
                    style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                    textAlign: TextAlign.center,
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
                      controller: controllerOtp,
                      validator: validateOtp,
                      decoration: InputDecoration(
                        hintText: "Code à 6 chiffres",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: const Color.fromARGB(255, 39, 176, 142).withOpacity(0.1),
                        filled: true,
                        prefixIcon: const Icon(Icons.lock_clock),
                      ),
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: _isLoading ? null : _verifyOTP,
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              "Vérifier le code",
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
                    onPressed: _isLoading ? null : _resendOTP,
                    child: const Text(
                      "Renvoyer le code",
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