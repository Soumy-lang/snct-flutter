import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LignesTab extends StatefulWidget {
  const LignesTab();
@override
  State<LignesTab> createState() => _LignesTabState();
}

class _LignesTabState extends State<LignesTab> {
  final Set<String> favoris = {};
  final String _prefsKey = 'favoris_lignes';

  final List<Map<String, dynamic>> lignes = [
      {'name': 'PRACOMTAL - FORTUNEAU/CHATEAUNEUF', 'accessible': false ,'number':'1','color':Colors.red,},
      {'name': 'DE GAULLE - LE ROURE', 'accessible': false,'number':'10','color':Colors.pink},
      {'name': 'DE GAULLE - CHATEAUNEUF', 'accessible': true,'number':'11','color':Colors.pinkAccent},
      {'name': 'DE GAULLE - DURAS', 'accessible': true,'number':'12','color':Colors.lightBlue},
      {'name': 'DE GAULLE - SYLVA CAMPUS', 'accessible': true ,'number':'13','color':Colors.green},
    ];

    String searchQuery = '';
  final TextEditingController searchController = TextEditingController();
@override
  void initState() {
    super.initState();
    _loadFavoris();
  }

  Future<void> _loadFavoris() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList(_prefsKey);
    setState(() {
      favoris 
      ..clear()
      ..addAll(saved?.toSet() ?? {});
    });
  }

  Future<void> _saveFavoris() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_prefsKey, favoris.toList());
  }
 void toggleFavori(String nom) {
    setState(() {
      if (favoris.contains(nom)) {
        favoris.remove(nom);
      } else {
        favoris.add(nom);
      }
    });
    _saveFavoris();
  }

  @override
  Widget build(BuildContext context) {
final favorisLignes= lignes.where((lignes) => favoris.contains(lignes['name'])).toList();

final List<Map<String, dynamic>> filteredLignes = lignes.where((lignes) {
      final name = lignes['name'].toString().toLowerCase();
      return name.contains(searchQuery.toLowerCase());
    }).toList();
  
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: 'Rechercher une ligne',
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
          onChanged: (value) {
            setState(() {
              searchQuery = value;
            });
          },
        ),
        const SizedBox(height: 16),
        const SectionTitle(title: 'Lignes favorites'),
        if (favorisLignes.isNotEmpty)
        ...favorisLignes.map((lignes) => ArretTile(
              name: lignes['name'],
              accessible: lignes['accessible'],
              isFavorite: true,
              onStarTap: () => toggleFavori(lignes['name']),
            ))
      else
        const Text(
          'Retrouve facilement les lignes que tu fréquentes le plus. Pour ajouter des lignes en favoris, clique sur l\'étoile à côté du nom des lignes.',
        ),
        const SizedBox(height: 16),
        const SectionTitle(title: 'Toutes les lignes'),
        ...filteredLignes.map((lignes) => LigneTile(
              name: lignes['name'],
              number:lignes['number'],
              color:lignes['color'],
              accessible: lignes['accessible'],
              isFavorite: favoris.contains(lignes['name']),
              onStarTap: () => toggleFavori(lignes['name']),
            )),
      ],
    );
  }
}

class ArretsTab extends StatefulWidget  {
  const ArretsTab();
@override
  State<ArretsTab> createState() => _ArretsTabState();
}

class _ArretsTabState extends State<ArretsTab> {
  final Set<String> favoris = {};
  final String _prefsKey = 'favoris_arrets';

  final List<Map<String, dynamic>> arrets = [
      {'name': 'Aldridge', 'accessible': false},
      {'name': 'Aldridges', 'accessible': false},
      {'name': 'Alohat - Tropenas', 'accessible': true},
      {'name': 'Aloha - Tropenas', 'accessible': true},
      {'name': 'ANCONE Revellin', 'accessible': true},
    ];
String searchQuery = '';
  final TextEditingController searchController = TextEditingController();
    @override
  void initState() {
    super.initState();
    _loadFavoris();
  }

  Future<void> _loadFavoris() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList(_prefsKey);
    setState(() {
      favoris 
      ..clear()
      ..addAll(saved?.toSet() ?? {});
    });
  }

  Future<void> _saveFavoris() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_prefsKey, favoris.toList());
  }

  void toggleFavori(String nom) {
    setState(() {
      if (favoris.contains(nom)) {
        favoris.remove(nom);
      } else {
        favoris.add(nom);
      }
    });
    _saveFavoris(); 
  }

  @override
  Widget build(BuildContext context) {
final favorisArrets = arrets.where((arret) => favoris.contains(arret['name'])).toList();

final List<Map<String, dynamic>> filteredArrets = arrets.where((arret) {
      final name = arret['name'].toString().toLowerCase();
      return name.contains(searchQuery.toLowerCase());
    }).toList();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: 'Rechercher un arrêt',
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
          onChanged: (value) {
            setState(() {
              searchQuery = value;
            });
          },
        ),
        const SizedBox(height: 16),
        const SectionTitle(title: 'Arrêts favoris'),
        if (favorisArrets.isNotEmpty)
        ...favorisArrets.map((arret) => ArretTile(
              name: arret['name'],
              accessible: arret['accessible'],
              isFavorite: true,
              onStarTap: () => toggleFavori(arret['name']),
            ))
      else
          Text(
          'Retrouve facilement les arrêts que tu fréquentes le plus. Pour ajouter des arrêts en favoris, clique sur l\'étoile à côté du nom des arrêts.',
        ),
        const SizedBox(height: 16),
        const SectionTitle(title: 'Tous les arrêts'),
        ...filteredArrets.map((arret) => ArretTile(
              name: arret['name'],
              accessible: arret['accessible'],
              isFavorite: favoris.contains(arret['name']),
              onStarTap: () => toggleFavori(arret['name']),
            )),
      ],
    );
  }
}

class SearchBar extends StatelessWidget {
  final String hintText;
  const SearchBar({required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
  }
}

class LigneTile extends StatelessWidget {
  final String number;
  final Color color;
  final String name;
  final bool accessible;
  final bool isFavorite;
  final VoidCallback onStarTap;

  const LigneTile({required this.number, required this.color, required this.name, required this.accessible, required this.isFavorite, required this.onStarTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 4),
      leading: CircleAvatar(
        backgroundColor: color,
        child: Text(number, style: const TextStyle(color: Colors.white)),
      ),
      title: Text('LIGNE $number : $name'),
      trailing: GestureDetector(
        onTap: onStarTap,
        child: Icon(
          isFavorite ? Icons.star : Icons.star_border,
          color: Colors.orange,
        ),
      ),
    );
  }
}

class ArretTile extends StatelessWidget {
  final String name;
  final bool accessible;
  final bool isFavorite;
  final VoidCallback onStarTap;

  const ArretTile({required this.name, this.accessible = false, required this.isFavorite,
    required this.onStarTap});

  @override
    Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (accessible) const Icon(Icons.accessible, size: 20),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: onStarTap,
            child: Icon(
              isFavorite ? Icons.star : Icons.star_border,
              color: Colors.orange,
            ),
          ),
        ],
      ),
    );
  }
}
