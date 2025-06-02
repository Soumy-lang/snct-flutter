import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/user/TrajetModel.dart';
import 'cart_provider.dart';

class AchatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: const Text(""),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Acheter"),
              Tab(text: "Mes titres"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            AcheterTab(),
            Center(child: Text("Mes titres ici")),
          ],
        ),
      ),
    );
  }
}

class AcheterTab extends StatelessWidget {
  const AcheterTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        SectionPliable(
          title: "Billeterie",
          initiallyExpanded: false,
          child: Padding(
            padding: EdgeInsets.all(12),
            child: BilleteriesGrid(),
          ),
        ),
        SizedBox(height: 16),
        SectionPliable(
          title: "Abonnements SNCT",
          initiallyExpanded: true,
          child: AbonnementsGrid(),
        ),
      ],
    );
  }
}

class SectionPliable extends StatelessWidget {
  final String title;
  final Widget child;
  final bool initiallyExpanded;

  const SectionPliable({
    required this.title,
    required this.child,
    this.initiallyExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        trailing: Text(
          initiallyExpanded ? "Masquer" : "Afficher",
          style: const TextStyle(color: Colors.orange),
        ),
        initiallyExpanded: initiallyExpanded,
        children: [child],
      ),
    );
  }
}


class BilleteriesGrid extends StatelessWidget {
  const BilleteriesGrid();

  @override
  Widget build(BuildContext context) {
    final List<TrajetModel> trajets = [
      TrajetModel(
        departureTime: "06:41",
        arrivalTime: "09:13",
        from: "Paris Gare de Lyon",
        to: "Lyon St-Exupéry TGV",
        trainLabel: "FR 9281",
        company: "FRECCIAROSSA",
        duration: "2 h 32 min • 1 correspondance",
        price: "aucun prix trouvé",
        isAvailable: false,
      ),
      TrajetModel(
        departureTime: "07:13",
        arrivalTime: "09:06",
        from: "Paris Gare de Lyon",
        to: "Lyon St-Exupéry TGV",
        trainLabel: "TGV INOUI 6905",
        company: "TGV INOUI",
        duration: "1 h 53 min • direct",
        price: "46,00 €",
        isAvailable: true,
      ),
    ];

    return Column(
      children: trajets.map((t) => TrajetCard(trajet: t)).toList(),
    );
  }
}


class TrajetCard extends StatelessWidget {
  final TrajetModel trajet;

  const TrajetCard({required this.trajet});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Heure et prix
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${trajet.departureTime} → ${trajet.arrivalTime}",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text(
                  trajet.isAvailable ? trajet.price : "aucun prix trouvé",
                  style: TextStyle(
                    color: trajet.isAvailable ? Colors.black : Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            /// Lieux
            Text("${trajet.from} → ${trajet.to}",
                style: const TextStyle(color: Colors.black54, fontSize: 14)),
            const SizedBox(height: 4),
            /// Train + compagnie
            Text(trajet.trainLabel, style: const TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 4),
            Text(trajet.duration, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 8),
            /// Ajouter au panier
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: trajet.isAvailable
                    ? () {
              Provider.of<CartProvider>(context, listen: false).addToCarts(trajet);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(backgroundColor: Colors.green, content: Text("${trajet.from} → ${trajet.to} ajouté au panier",style:  TextStyle(backgroundColor: Colors.green))),
  );
            }
                    : null,
                icon: const Icon(Icons.shopping_cart),
                label: const Text("Ajouter au panier"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.grey[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




class AbonnementsGrid extends StatelessWidget {
  const AbonnementsGrid();

  @override
  Widget build(BuildContext context) {
    final List<PassModel> passes = [
      PassModel("PASS Annuel Scolaire", "PASS Annuel 2025-2026 -18 ans", "60,00 €"),
      PassModel("PASS Mensuel Jeune", "Mensuel Jeune -26 ans Juin 2025", "12,00 €"),
      PassModel("PASS Annuel Jeune", "Abonnement Annuel Jeune", "80,00 €"),
      PassModel("PASS Mensuel Liberté", "Abonnement Mensuel Liberté", "20,00 €"),
    ];

    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: passes.map((p) => PassCard(pass: p)).toList(),
    );
  }
}

class PassCard extends StatelessWidget {
  final PassModel pass;

  const PassCard({required this.pass});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children:  [
              CircleAvatar(
                backgroundColor:null,
                radius: 24,
                child:FittedBox(
    child: Padding(padding:EdgeInsets.all(6),
    child:Image.asset(
      'images/logo.png'
    ),),
  ),
              ),
              Spacer(),
              Icon(Icons.info_outline, color: Colors.teal),
            ],
          ),
          const SizedBox(height: 12),
          Text(pass.label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(pass.description, style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 12),
          Text(pass.price, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              Provider.of<CartProvider>(context, listen: false).addToCart(pass);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(backgroundColor: Colors.green, content: Text("${pass.label} ajouté au panier",style:  TextStyle(backgroundColor: Colors.green))),
  );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text("Ajout au panier"),
          ),
        ],
      ),
    );
  }
}
