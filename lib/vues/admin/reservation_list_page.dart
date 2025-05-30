import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ReservationListPage extends StatefulWidget {
  @override
  State<ReservationListPage> createState() => _ReservationListPageState();
}

class _ReservationListPageState extends State<ReservationListPage> {
  List<Map<String, dynamic>> reservations = [];

  @override
  void initState() {
    super.initState();
    fetchReservations();
  }

  Future<void> fetchReservations() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:3000/reservations'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          reservations = data.cast<Map<String, dynamic>>();
        });
      } else {
        print("Erreur lors du chargement des réservations : ${response.statusCode}");
      }
    } catch (e) {
      print("Erreur réseau : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color cardColor = Color.fromARGB(255, 39, 176, 142).withOpacity(0.1);

    return Scaffold(
      appBar: AppBar(
        title: Text("Réservations"),
        backgroundColor: Color.fromARGB(255, 39, 176, 142),
      ),
      body: reservations.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: EdgeInsets.all(12),
              itemCount: reservations.length,
              itemBuilder: (_, index) {
                final r = reservations[index];
                return Card(
                  color: cardColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 4,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.train, color: Color.fromARGB(255, 39, 176, 142)),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                "Train : ${r['trainId'] ?? '—'}",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Client : ${r['userId'] ?? '—'}",
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(height: 8),
                        Divider(),
                        SizedBox(height: 8),
                        Text("Départ : ${r['departure'] ?? '—'} → Arrivée : ${r['arrival'] ?? '—'}"),
                        SizedBox(height: 4),
                        Text("Tarif : ${r['price'] ?? 0} MAD"),
                        SizedBox(height: 4),
                        Text("Date du voyage : ${r['reservationDate']?.toString().substring(0, 16) ?? '—'}"),
                        SizedBox(height: 4),
                        Text("Date d'achat : ${r['purchaseDate']?.toString().substring(0, 16) ?? '—'}"),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
