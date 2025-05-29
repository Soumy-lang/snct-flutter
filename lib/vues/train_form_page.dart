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
  late TextEditingController nameController;
  late TextEditingController departureController;
  late TextEditingController arrivalController;

  DateTime? departureTime;
  DateTime? arrivalTime;

  bool isAvailable = true;
  bool isOnTrip = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.train?['name'] ?? '');
    departureController = TextEditingController(text: widget.train?['departure'] ?? '');
    arrivalController = TextEditingController(text: widget.train?['arrival'] ?? '');
    isAvailable = widget.train?['available'] ?? true;
    isOnTrip = widget.train?['onTrip'] ?? false;

    if (widget.train != null) {
      departureTime = DateTime.tryParse(widget.train!['departureTime'] ?? '');
      arrivalTime = DateTime.tryParse(widget.train!['arrivalTime'] ?? '');
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final trainData = {
      'name': nameController.text,
      'departure': departureController.text,
      'arrival': arrivalController.text,
      'departureTime': departureTime!.toIso8601String(),
      'arrivalTime': arrivalTime!.toIso8601String(),
      'available': isAvailable,
      'onTrip': isOnTrip,
    };

    print(widget.train?['_id']);

    final uri = widget.train == null
        ? Uri.parse('http://localhost:3000/trains')
        : Uri.parse('http://localhost:3000/trains/${widget.train!['_id']}');

    final response = widget.train == null
        ? await http.post(uri, headers: {'Content-Type': 'application/json'}, body: json.encode(trainData))
        : await http.put(uri, headers: {'Content-Type': 'application/json'}, body: json.encode(trainData));

    if (response.statusCode == 200 || response.statusCode == 201) {
      Navigator.pop(context);
    } else {
      print('Erreur API (${response.statusCode}): ${response.body}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur API : ${response.statusCode}")),
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.train == null ? "Ajouter Train" : "Modifier Train")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(controller: nameController, decoration: InputDecoration(labelText: 'Nom'), validator: (v) => v!.isEmpty ? 'Champ requis' : null),
              TextFormField(controller: departureController, decoration: InputDecoration(labelText: 'Départ'), validator: (v) => v!.isEmpty ? 'Champ requis' : null),
              TextFormField(controller: arrivalController, decoration: InputDecoration(labelText: 'Arrivée'), validator: (v) => v!.isEmpty ? 'Champ requis' : null),
              ListTile(
                title: Text("Heure départ: ${departureTime?.toLocal().toString().split('.')[0] ?? 'Non défini'}"),
                trailing: Icon(Icons.access_time),
                onTap: () async {
                  departureTime = await showDateTimePicker(context);
                  setState(() {});
                },
              ),
              ListTile(
                title: Text("Heure arrivée: ${arrivalTime?.toLocal().toString().split('.')[0] ?? 'Non défini'}"),
                trailing: Icon(Icons.access_time),
                onTap: () async {
                  arrivalTime = await showDateTimePicker(context);
                  setState(() {});
                },
              ),
              SwitchListTile(title: Text("Disponible"), value: isAvailable, onChanged: (val) => setState(() => isAvailable = val)),
              SwitchListTile(title: Text("Sur trajet"), value: isOnTrip, onChanged: (val) => setState(() => isOnTrip = val)),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _submit, child: Text("Enregistrer")),
            ],
          ),
        ),
      ),
    );
  }

  Future<DateTime?> showDateTimePicker(BuildContext context) async {
    final date = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2023), lastDate: DateTime(2030));
    if (date == null) return null;
    final time = await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (time == null) return null;
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }
}
