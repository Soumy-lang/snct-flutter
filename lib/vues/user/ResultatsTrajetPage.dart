import 'package:flutter/material.dart';
import '../../widgets/user/myBottomAppBar.dart';


class TrajetPage_results extends StatelessWidget {
  final List<dynamic> resultats;

  const TrajetPage_results({required this.resultats});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Résultats de trajet")),
        bottomNavigationBar:MyBottomAppBar(currentIndex: 1),
      body: ListView.builder(
        itemCount: resultats.length,
        itemBuilder: (context, index) {
          final trajet = resultats[index];
          return ListTile(
            title: Text("De: ${trajet['depart']} → ${trajet['destination']}"),
            subtitle: Text("Durée: ${trajet['duration'] ?? 'Inconnue'}"),
          );
        },
      ),
    );
  }
}
