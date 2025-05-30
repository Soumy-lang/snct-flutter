import 'package:flutter/material.dart';

class HomePageAdmin extends StatelessWidget {
  final List<Map<String, String>> destinations = [
    {
      'title': 'Russie - Moscou',
      'image': '../assets/images/moscou.jpg',
    },
    {
      'title': 'Kazakhstan - Astana',
      'image': '../assets/images/astana.jpg',
    },
    {
      'title': 'Mongolie - Oulan-Bator',
      'image': '../assets/images/ulaanbaatar.jpg',
    },
    {
      'title': 'Chine - Pékin',
      'image': '../assets/images/pekin.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              '../assets/images/logo.jpg',
              height: 40,
            ),
            SizedBox(width: 10),
            Text("Gestion administrative"),
          ],
        ),
        backgroundColor: Colors.teal[700],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  buildCard(
                    context,
                    icon: Icons.train,
                    label: "Gérer les Trajets",
                    route: '/trains',
                    color: Colors.orange,
                  ),
                  buildCard(
                    context,
                    icon: Icons.list_alt,
                    label: "Tous les Trains",
                    route: '/tous_les_trains',
                    color: Colors.blue,
                  ),
                  buildCard(
                    context,
                    icon: Icons.book_online,
                    label: "Toutes les réservations",
                    route: '/reservations',
                    color: Colors.green,
                  ),
                ],
              ),
            ),
            Divider(thickness: 1, color: Colors.grey[400]),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Destinations populaires',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
            ),
            ),

            Column(
              children: destinations.map((destination) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 200,
                          child: Image.network(
                            destination['image']!,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 200,
                          color: Colors.black.withOpacity(0.3),
                        ),
                        Positioned(
                          bottom: 10,
                          left: 10,
                          child: Text(
                            destination['title']!,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(blurRadius: 4, color: Colors.black),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: 20),

          ],
        ),
      ),
    );
  }

  Widget buildCard(BuildContext context,
      {required IconData icon,
      required String label,
      required String route,
      required Color color}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, size: 30, color: color),
        title: Text(label, style: TextStyle(fontSize: 18)),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () => Navigator.pushNamed(context, route),
      ),
    );
  }
}
