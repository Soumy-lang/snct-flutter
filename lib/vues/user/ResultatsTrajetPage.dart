import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/user/myBottomAppBar.dart';
import '../../widgets/user/titres/cart_provider.dart';
import '../../models/user/TrajetModel.dart';

class TrajetPage_results extends StatelessWidget {
  final List<dynamic> resultats;

  const TrajetPage_results({required this.resultats});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Résultats de trajet")),
      bottomNavigationBar: MyBottomAppBar(currentIndex: 1),
      body: ListView.builder(
        itemCount: resultats.length,
        itemBuilder: (context, index) {
          final trajet = resultats[index];

          return Consumer<CartProvider>(
            builder: (context, cart, _) {
              return ListTile(
                title: Text("De: ${trajet['depart']} → ${trajet['destination']}"),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Text("Ref: ${trajet['train'] ?? 'Inconnue'}"),
                    Text(" Disponible: ${trajet['disponible'] ?? 'Non '}"),
                    Text(" Ligne: ${trajet['ligne'] ?? 'Inconnue '}"),
                    Text(" Prix: ${trajet['price'] ?? 'Inconnue '}"),
                    ],)
                    

                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.add_shopping_cart, color: Colors.orange),
                  onPressed: () {
                    final trajetModel = TrajetModel(
                      departureTime: trajet['heure_depart'] ?? '',
                      arrivalTime: trajet['heure_arrivee'] ?? '',
                      from: trajet['depart'] ?? '',
                      to: trajet['destination'] ?? '',
                      trainLabel: trajet['ligne'] ?? '',
                      company: 'SNCT',
                      duration: trajet['duration'] ?? '',
                      price: trajet['prix'] ?? '0.00 €',
                      isAvailable: true,
                    );

                    cart.addToCarts(trajetModel);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Ajouté au panier : ${trajetModel.from} → ${trajetModel.to}"),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
