import 'package:flutter/material.dart';
import 'package:snct_app/services/auth/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final controllerEmail = TextEditingController();
  final controllerMdp = TextEditingController();

  String email = "";

  String mdp = "";


  @override
  void dispose() {
    controllerEmail.dispose();
    controllerMdp.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              header(context),
              inputField(context),
              forgotPassword(context),
              signup(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget header(context) {
    return const Column(
      children: [
        Text(
          "Bienvenue sur SNCT !",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text("Merci de compléter ce formulaire pour vous connecter"),
      ],
    );
  }

  Widget inputField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          onSaved: (newValue) {
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
        const SizedBox(height: 10),
        TextFormField(
          onSaved: (newValue) {
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
            fillColor: const Color.fromARGB(255, 39, 176, 142).withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(Icons.password),
          ),
          obscureText: true,
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              // Form is valid, proceed with login
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Connexion en cours...'),
                  duration: Duration(seconds: 2),
                ),
              );
                final success = await AuthService.login(
                  controllerEmail.text,
                  controllerMdp.text,
                );
                if (success) {
                  Navigator.pushReplacementNamed(context, '/admin');
                  print("Less goo");
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Identifiants invalides")),
                  );
                }
            }
          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: Color.fromARGB(255, 39, 176, 142),
          ),
          child: const Text(
            "Connexion",
            style: TextStyle(
              fontSize: 20,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        )
      ],
    );
  }

  Widget forgotPassword(context) {
    return TextButton(
      onPressed: () {},
      child: const Text(
        "Mot de passe oublié ?",
        style: TextStyle(color: Color.fromARGB(255, 39, 176, 142)),
      ),
    );
  }

  Widget signup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Pas de compte ? "),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, "/register");
          },
          child: const Text(
            "S'inscrire",
            style: TextStyle(color: Color.fromARGB(255, 39, 176, 142)),
          ),
        )
      ],
    );
  }
}