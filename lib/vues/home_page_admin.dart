import 'package:flutter/material.dart';

class HomePageAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Admin Home")),
      body: Column(
        children: [
          ListTile(
            title: Text("Gérer les Trains"),
            onTap: () => Navigator.pushNamed(context, '/trains'),
          ),
          ListTile(
            title: Text("Tous les Trains"),
            onTap: () => Navigator.pushNamed(context, '/tous_les_trains'),
          ),
          ListTile(
            title: Text("Voir Réservations"),
            onTap: () => Navigator.pushNamed(context, '/reservations'),
          ),
        ],
      ),
    );
  }
}
