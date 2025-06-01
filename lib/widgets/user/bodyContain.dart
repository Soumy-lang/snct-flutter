import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../models/user/userModel.dart';

class MybodyContain extends StatefulWidget {
  @override

  _MybodyContain createState()=>_MybodyContain();}


  class _MybodyContain extends State<MybodyContain> {
  final positionController =TextEditingController();
  final destinationController =TextEditingController();  

  void trajet()async {
    final SearchTrajet= Search(
      depart:positionController.text,
      destination:destinationController.text,
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [DestinationSection(), ResumSection()]),
      ),
    );

  }
}

class DestinationSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      padding: const EdgeInsets.fromLTRB(10, 25, 10, 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 4,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column (children: [ 
                    const TextField(
                    decoration: InputDecoration(
                      hintText: 'Votre position',
                      contentPadding: EdgeInsets.all(10),
                      border: InputBorder.none,
                    ),
                  ),
                  const TextField(
                    decoration: InputDecoration(
                      hintText: 'Destination',
                      contentPadding: EdgeInsets.all(10),
                      border: InputBorder.none,
                    ),
                  ),
                  ]
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.green,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 4,
                      offset: Offset(0, 3),
                    ),
                  ],
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                ),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    
                    shape: const CircleBorder(),
                    backgroundColor: const Color.fromARGB(255, 122, 222, 233),
                    padding: const EdgeInsets.all(10),
                    elevation: 0,
                  ),
                  child: const Icon(Icons.search, size: 26),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5)
        ],
      ),
    );
  }
}



class ResumSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          HeaderSection(),
          TicketCard(),
          NearbySection(),
          NoStationsCard(),
          MapInfoBanner(),
          FavoritesSection(),
          FavoritesCard(),
        ],
      ),
    );
  }
}

// SECTION: Header "Me déplacer"
class HeaderSection extends StatelessWidget {
  const HeaderSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text('Me déplacer', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text('Mes titres >', style: TextStyle(color: Colors.orange)),
        ],
      ),
    );
  }
}

// TICKET CARD
class TicketCard extends StatelessWidget {
  const TicketCard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFF1F6FF),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: const [
            Icon(Icons.shopping_bag, color: Colors.orange, size: 32),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('SNCT', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text('Acheter un titre', style: TextStyle(color: Colors.orange)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// SECTION: "À proximité"
class NearbySection extends StatelessWidget {
  const NearbySection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text('Infos trafic et réseaux', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text('Plan interactif', style: TextStyle(color: Colors.orange)),
        ],
      ),
    );
  }
}

class NoStationsCard extends StatelessWidget {
  const NoStationsCard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(Icons.directions_train, size: 64, color: Colors.grey),
            const SizedBox(height: 12,width: 100,),
            const Text(
              "! Perturbations",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class MapInfoBanner extends StatelessWidget {
  const MapInfoBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 24),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: Color(0xFFE4EBFA),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,        
      ),
    );
  }
}

class FavoritesSection extends StatelessWidget {
  const FavoritesSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: const Text('Mes favoris', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }
}

class FavoritesCard extends StatelessWidget {
  const FavoritesCard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(20),
        child: const Text('Retrouve rapidement les infos de tes favoris (arrêts, lignes...)'),
      ),
    );
  }
}

