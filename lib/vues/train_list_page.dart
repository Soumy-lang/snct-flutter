import 'package:flutter/material.dart';
import 'train_form_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TrainListPage extends StatefulWidget {
  @override
  State<TrainListPage> createState() => _TrainListPageState();
}

class _TrainListPageState extends State<TrainListPage> {
  List<dynamic> trains = [];

  @override
  void initState() {
    super.initState();
    fetchTrains();
  }

  Future<void> fetchTrains() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:3000/trains')); 

      if (response.statusCode == 200) {
        setState(() {
          trains = json.decode(response.body);
        });
      } else {
        print("Erreur de chargement : ${response.statusCode}");
      }
    } catch (e) {
      print("Erreur réseau : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Liste des Trains')),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text("Train")),
            DataColumn(label: Text("Départ")),
            DataColumn(label: Text("Arrivée")),
            DataColumn(label: Text("Heure Départ")),
            DataColumn(label: Text("Heure Arrivée")),
            DataColumn(label: Text("Perturbations")),
            DataColumn(label: Text("Sur trajet")),
            DataColumn(label: Text("Signaler un changement")),
          ],
          rows: trains.map((train) {
            return DataRow(cells: [
              DataCell(Text(train['name'] ?? '')),
              DataCell(Text(train['departure'] ?? '')),
              DataCell(Text(train['arrival'] ?? '')),
              DataCell(Text(train['departureTime']?.toString().substring(0, 16) ?? '')),
              DataCell(Text(train['arrivalTime']?.toString().substring(0, 16) ?? '')),
              DataCell(Text(train['issues'] == true ? "Non" : "Oui")),
              DataCell(Text(train['onTrip'] == true ? "Oui" : "Non")),
              DataCell(Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (_) => TrainFormPage(train: train),
                      )).then((_) => fetchTrains());
                    },
                  ),
                ],
              )),
            ]);
          }).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (_) => TrainFormPage(),
          )).then((_) => fetchTrains());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
