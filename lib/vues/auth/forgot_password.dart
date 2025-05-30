import 'package:flutter/material.dart';
import 'package:snct_app/services/otp.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SendOtpScreen extends StatefulWidget {
  const SendOtpScreen({super.key});

  @override
  State<SendOtpScreen> createState() => _SendOtpScreenState();
}

class _SendOtpScreenState extends State<SendOtpScreen> {
  final _formKey = GlobalKey<FormState>();
  final controllerEmail = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    controllerEmail.dispose();
    super.dispose();
  }


  Future<void> _saveEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('reset_email', email);
  }

  Future<void> _sendOTP() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      
      final response = await OtpService.postRequest(
        'send', 
        {'email': controllerEmail.text.trim()}
      );

      setState(() => _isLoading = false);

      if (response['status'] == 200) {
        await _saveEmail(controllerEmail.text.trim());
        Navigator.pushNamed(context, '/verify-otp', arguments: controllerEmail.text.trim()
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response['body']['message'])),
        );
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
                    "Mot de passe oublié",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Entrez votre email pour réinitialiser",
                    style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                  )
                ],
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: controllerEmail,
                      validator: validateEmail,
                      decoration: InputDecoration(
                        hintText: "Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: const Color.fromARGB(255, 39, 176, 142).withOpacity(0.1),
                        filled: true,
                        prefixIcon: const Icon(Icons.mail),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: _isLoading ? null : _sendOTP,
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              "Envoyer le code",
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
                      "Retour à la connexion",
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