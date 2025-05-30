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
  Map<String, dynamic> issuesDetails = {};

  @override
  void initState() {
    super.initState();
    fetchTrains();
  }

  Future<void> fetchTrains() async {
    try {
      final trainsResponse = await http.get(Uri.parse('http://localhost:3000/trains'));
      if (trainsResponse.statusCode == 200) {
        final trainsData = json.decode(trainsResponse.body);

        final issuesResponse = await http.get(Uri.parse('http://localhost:3000/issues'));
        if (issuesResponse.statusCode == 200) {
          final issuesData = json.decode(issuesResponse.body);

          final Map<String, dynamic> issuesMap = {};
          for (var issue in issuesData) {
            final trainId = issue['trainId'];
            if (!issuesMap.containsKey(trainId)) {
              issuesMap[trainId] = [];
            }
            issuesMap[trainId].add(issue['description']);
          }

          setState(() {
            trains = trainsData;
            issuesDetails = issuesMap;
          });
        } else {
          print("Erreur chargement issues: ${issuesResponse.statusCode}");
          setState(() {
            trains = trainsData;
            issuesDetails = {};
          });
        }
      } else {
        print("Erreur de chargement trains : ${trainsResponse.statusCode}");
      }
    } catch (e) {
      print("Erreur réseau : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Liste des Trains')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: trains.length,
          itemBuilder: (context, index) {
            final train = trains[index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 8),
              color: Color.fromARGB(255, 39, 176, 142).withOpacity(0.1),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(train['name'] ?? 'Train sans nom',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.train, color: Colors.green[700], size: 20),
                        SizedBox(width: 6),
                        Text("Départ : ${train['departure'] ?? 'N/A'}"),
                        SizedBox(width: 16),
                        Text("Arrivée : ${train['arrival'] ?? 'N/A'}"),
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.access_time, size: 18),
                        SizedBox(width: 6),
                        Text("Départ : ${train['departureTime']?.toString().substring(0, 16) ?? ''}"),
                        SizedBox(width: 16),
                        Text("Arrivée : ${train['arrivalTime']?.toString().substring(0, 16) ?? ''}"),
                      ],
                    ),
                    SizedBox(height: 6),
                    // Text("Perturbations : ${train['issues'] == true ? 'Oui' : 'Non'}"),
                    Text("Sur le trajet : ${train['onTrip'] == true ? 'Oui' : 'Non'}"),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Perturbations : ${train['issues'] == true ? 'Oui' : 'Non'}"),
                        if (train['issues'] == true) 
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              issuesDetails[train['_id']] != null && issuesDetails[train['_id']]!.isNotEmpty
                                ? issuesDetails[train['_id']].join('\n')
                                : "Détails non disponibles",
                              style: TextStyle(color: Colors.red[700]),
                            ),
                          )
                        else
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text("Non"),
                          ),
                      ],
                    ),

                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => TrainFormPage(train: train),
                            ),
                          ).then((_) => fetchTrains());
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => TrainFormPage()),
          ).then((_) => fetchTrains());
        },
        child: Icon(Icons.add),
        // backgroundColor: Color.fromARGB(255, 39, 176, 142),
        tooltip: 'Ajouter un train',
      ),
    );
  }
}
