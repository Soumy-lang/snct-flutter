import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class NewTrainFormPage extends StatefulWidget {
  final Map<String, dynamic>? train;

  const NewTrainFormPage({this.train});

  @override
  _NewTrainFormPageState createState() => _NewTrainFormPageState();

}

class _NewTrainFormPageState extends State<NewTrainFormPage> {
  final _formKey = GlobalKey<FormState>();

  int? _sortColumnIndex;
  bool _sortAscending = true;

  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController statusController;
  bool isAvailable = true;

  List<Map<String, dynamic>> trainList = [];

  void _sortList(String key, int columnIndex, bool ascending) {
    trainList.sort((a, b) {
      final valA = a[key];
      final valB = b[key];
      if (valA is bool && valB is bool) {
        return ascending ? valA.toString().compareTo(valB.toString()) : valB.toString().compareTo(valA.toString());
      } else if (valA is String && valB is String) {
        return ascending ? valA.compareTo(valB) : valB.compareTo(valA);
      }
      return 0;
    });

    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.train?['name'] ?? '');
    descriptionController = TextEditingController(text: widget.train?['description'] ?? '');
    statusController = TextEditingController(text: widget.train?['status'] ?? '');
    isAvailable = widget.train?['available'] ?? true;
    fetchTrainList();
  }

  Future<void> fetchTrainList() async {
    final response = await http.get(Uri.parse('http://localhost:3000/trains-simple'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        trainList = List<Map<String, dynamic>>.from(data);
      });
    } else {
      print('Erreur chargement trains: ${response.statusCode}');
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final data = {
      'name': nameController.text,
      'description': descriptionController.text,
      'status': statusController.text,
      'available': isAvailable,
    };

    final url = widget.train == null
        ? Uri.parse('http://localhost:3000/trains-simple')
        : Uri.parse('http://localhost:3000/trains-simple/${widget.train!['_id']}');

    final response = widget.train == null
        ? await http.post(url, body: json.encode(data), headers: {'Content-Type': 'application/json'})
        : await http.put(url, body: json.encode(data), headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200 || response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Succès")));
      fetchTrainList();
      if (widget.train == null) {
        nameController.clear();
        descriptionController.clear();
        statusController.clear();
        setState(() => isAvailable = true);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur API : ${response.statusCode}")),
      );
    }
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
            Text(widget.train == null ? 'Ajouter un nouveau Train' : 'Modifier le Train'),
          ],
        ),
        backgroundColor: Colors.teal[700],
        foregroundColor: Colors.white, 
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(controller: nameController, decoration: InputDecoration(labelText: 'Nom'), validator: (v) => v!.isEmpty ? 'Champ requis' : null),
                  TextFormField(controller: descriptionController, decoration: InputDecoration(labelText: 'Description')),
                  TextFormField(controller: statusController, decoration: InputDecoration(labelText: 'État (ex: opérationnel, maintenance)')),
                  SwitchListTile(
                    title: Text("Disponible"),
                    value: isAvailable,
                    onChanged: (val) => setState(() => isAvailable = val),
                    activeColor: Color.fromARGB(255, 39, 176, 142),        
                    activeTrackColor: Color.fromARGB(100, 39, 176, 142),   
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 39, 176, 142), 
                      foregroundColor: Colors.white,  
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                    ),
                    child: Text("Enregistrer"),
                  ),
                ],
              ),
            ),
            Divider(height: 40),
            Text("Tous les trains :", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 10),

            ...trainList.map((train) {
            return Card(
              margin: EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                title: Text(train['name'] ?? '', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Description: ${train['description'] ?? ''}"),
                    Text("État: ${train['status'] ?? ''}"),
                    Text("Disponible: ${train['available'] == true ? 'Oui' : 'Non'}"),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => NewTrainFormPage(train: train),
                      ),
                    ).then((_) => fetchTrainList());
                  },
                ),
              ),
            );
          }).toList(),
          ],
        ),
      ),
    );
  }
}
