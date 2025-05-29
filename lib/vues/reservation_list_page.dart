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
    return Scaffold(
      appBar: AppBar(title: Text("Réservations")),
      body: reservations.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: reservations.length,
              itemBuilder: (_, index) {
                final r = reservations[index];
                return ListTile(
                  title: Text("Train ID: ${r['trainId']} - Utilisateur: ${r['userId']}"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Départ: ${r['departure']} → Arrivée: ${r['arrival']}"),
                      Text("Tarif: ${r['price']} MAD"),
                      Text("Réservation: ${r['reservationDate']?.toString().substring(0, 16) ?? '—'}"),
                      Text("Achat: ${r['purchaseDate']?.toString().substring(0, 16) ?? '—'}"),
                    ],
                  ),
                  isThreeLine: true,
                );
              },
            ),
    );
  }
}
