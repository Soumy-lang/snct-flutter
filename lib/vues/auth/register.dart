import 'package:flutter/material.dart';
import 'package:snct_app/services/auth/auth.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final controllerEmail = TextEditingController();
  final controllerMdp = TextEditingController();
  final controllerConfirmMdp = TextEditingController();

  String email = "";

  String mdp = "";
  
  String confirmMdp = "";



  @override
  void dispose() {
    controllerEmail.dispose();
    controllerMdp.dispose();
    controllerConfirmMdp.dispose();
    super.dispose();
  }
  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez confirmer le mot de passe';
    }
    if (value != controllerMdp.text) {
      return 'Les mots de passe ne correspondent pas';
    }
    return null;
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
                    "S'inscrire",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Créer votre compte",
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
                      onSaved:(newValue) {
                        email = newValue!;
                      },
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
                    const SizedBox(height: 20),
                    TextFormField(
                      onSaved:(newValue) {
                        mdp = newValue!;
                      },
                      controller: controllerMdp,
                      validator: validatePassword,
                      decoration: InputDecoration(
                        hintText: "Mot de passe",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Color.fromARGB(255, 39, 176, 142).withOpacity(0.1),
                        filled: true,
                        prefixIcon: const Icon(Icons.password),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      onSaved:(newValue) {
                        confirmMdp = newValue!;
                      },
                      controller: controllerConfirmMdp,
                      validator:validateConfirmPassword,
                      decoration: InputDecoration(
                        hintText: "Confirmer mot de passe",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Color.fromARGB(255, 39, 176, 142).withOpacity(0.1),
                        filled: true,
                        prefixIcon: const Icon(Icons.password),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Inscription en cours...'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                                  final success = await AuthService.register(
                                    controllerEmail.text,
                                    controllerMdp.text,
                                  );
                                  if (success) {
                                     Navigator.pushReplacementNamed(context, '/user');
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("Échec de l'inscription")),
                                    );
                                  }
                          }
                        },
                        child: const Text(
                          "S'inscrire",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          minimumSize: const Size(double.infinity, 50),
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          backgroundColor: Color.fromARGB(255, 39, 176, 142),
                        ),
                      ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text("Déjà un compte ?"),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/login");
                    },
                    child: const Text(
                      "Se connecter",
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