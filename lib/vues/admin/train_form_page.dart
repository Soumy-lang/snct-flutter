import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TrainFormPage extends StatefulWidget {
  final Map<String, dynamic>? train;

  const TrainFormPage({this.train});

  @override
  _TrainFormPageState createState() => _TrainFormPageState();
}

class _TrainFormPageState extends State<TrainFormPage> {
  final _formKey = GlobalKey<FormState>();
  List<dynamic> simpleTrains = [];
  List<dynamic> trainIssues = [];
  String? selectedTrainName;
  late TextEditingController departureController;
  late TextEditingController arrivalController;
  late TextEditingController issueController;

  DateTime? departureTime;
  DateTime? arrivalTime;

  bool isAvailable = true;
  bool isOnTrip = false;

  @override
  void initState() {
    super.initState();
    departureController = TextEditingController(text: widget.train?['departure'] ?? '');
    arrivalController = TextEditingController(text: widget.train?['arrival'] ?? '');
    issueController = TextEditingController();
    isAvailable = widget.train?['available'] ?? true;
    isOnTrip = widget.train?['onTrip'] ?? false;
    selectedTrainName = widget.train?['name'];

    if (widget.train != null) {
      departureTime = DateTime.tryParse(widget.train!['departureTime'] ?? '');
      arrivalTime = DateTime.tryParse(widget.train!['arrivalTime'] ?? '');

      // fetchIssuesForTrain(widget.train!['_id']);
    }
    fetchSimpleTrains();
  }

  Future<void> fetchSimpleTrains() async {
    final response = await http.get(Uri.parse('http://localhost:3000/trains-simple'));
    if (response.statusCode == 200) {
      setState(() {
        simpleTrains = json.decode(response.body);
      });
    } else {
      print('Erreur chargement trains simples: ${response.statusCode}');
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final trainData = {
      'name': selectedTrainName,
      'departure': departureController.text,
      'arrival': arrivalController.text,
      'departureTime': departureTime?.toIso8601String(),
      'arrivalTime': arrivalTime?.toIso8601String(),
      'available': isAvailable,
      'onTrip': isOnTrip,
    };

    final isUpdate = widget.train != null;
    final id = widget.train?['_id'];
    // print(id);
    final uri = isUpdate
        ? Uri.parse('http://localhost:3000/trains/$id')
        : Uri.parse('http://localhost:3000/trains');

    final response = isUpdate
        ? await http.put(uri,
            headers: {'Content-Type': 'application/json'},
            body: json.encode(trainData))
        : await http.post(uri,
            headers: {'Content-Type': 'application/json'},
            body: json.encode(trainData));

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (isUpdate && issueController.text.trim().isNotEmpty) {
        await http.post(
          Uri.parse('http://localhost:3000/issues'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'trainId': id,
            'description': issueController.text.trim(),
            'date': DateTime.now().toIso8601String(),
          }),
        );

        await http.put(
          Uri.parse('http://localhost:3000/trains/$id'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'issues': true}),
        );
      }

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur API : ${response.statusCode}")),
      );
    }
  }

  Future<DateTime?> showDateTimePicker(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
    );
    if (date == null) return null;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time == null) return null;
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

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
            Text(widget.train == null ? "Ajouter un Train" : "Modifier un Train"),
          ],
        ),
        backgroundColor: Colors.teal[700],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 4,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  DropdownButtonFormField<String>(
                    value: selectedTrainName != null && simpleTrains.any((t) => t['name'] == selectedTrainName)
                        ? selectedTrainName
                        : null,
                    decoration: InputDecoration(labelText: 'Nom du Train'),
                    items: simpleTrains.map<DropdownMenuItem<String>>((train) {
                      return DropdownMenuItem<String>(
                        value: train['name'],
                        child: Text(train['name']),
                      );
                    }).toList(),
                    onChanged: (value) => setState(() => selectedTrainName = value),
                    validator: (value) => value == null || value.isEmpty ? 'Sélection requise' : null,
                  ),
                  TextFormField(
                    controller: departureController,
                    decoration: InputDecoration(labelText: 'Ville de Départ'),
                    validator: (v) => v!.isEmpty ? 'Champ requis' : null,
                  ),
                  TextFormField(
                    controller: arrivalController,
                    decoration: InputDecoration(labelText: 'Ville d\'Arrivée'),
                    validator: (v) => v!.isEmpty ? 'Champ requis' : null,
                  ),
                  SizedBox(height: 16),
                  ListTile(
                    title: Text("Heure de Départ: ${departureTime?.toLocal().toString().split('.')[0] ?? 'Non définie'}"),
                    trailing: Icon(Icons.access_time),
                    onTap: () async {
                      final time = await showDateTimePicker(context);
                      if (time != null) setState(() => departureTime = time);
                    },
                  ),
                  ListTile(
                    title: Text("Heure d'Arrivée: ${arrivalTime?.toLocal().toString().split('.')[0] ?? 'Non définie'}"),
                    trailing: Icon(Icons.access_time),
                    onTap: () async {
                      final time = await showDateTimePicker(context);
                      if (time != null) setState(() => arrivalTime = time);
                    },
                  ),
                  SwitchListTile(
                    title: Text("Disponible"),
                    value: isAvailable,
                    onChanged: (val) => setState(() => isAvailable = val),
                    activeColor: Color.fromARGB(255, 39, 176, 142),        
                    activeTrackColor: Color.fromARGB(100, 39, 176, 142),   
                  ),
                  SwitchListTile(
                    title: Text("Sur un trajet"),
                    value: isOnTrip,
                    onChanged: (val) => setState(() => isOnTrip = val),
                    activeColor: Color.fromARGB(255, 39, 176, 142),        
                    activeTrackColor: Color.fromARGB(100, 39, 176, 142),   
                  ),
                  if (widget.train != null) ...[
                    SizedBox(height: 20),
                    TextFormField(
                      controller: issueController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: 'Signaler un problème',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Color.fromARGB(255, 39, 176, 142).withOpacity(0.05),
                      ),
                    ),
                  ],
                  SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: _submit,
                    icon: Icon(Icons.save),
                    label: Text("Enregistrer"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 39, 176, 142),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
