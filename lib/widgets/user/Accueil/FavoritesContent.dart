import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesContent extends StatefulWidget {
  const FavoritesContent({super.key});

  @override
  State<FavoritesContent> createState() => _FavoritesContentState();
}

class _FavoritesContentState extends State<FavoritesContent> {
  List<String> lignesFavoris = [];
  List<String> arretsFavoris = [];

  @override
  void initState() {
    super.initState();
    _loadFavoris();
  }

  Future<void> _loadFavoris() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      lignesFavoris = prefs.getStringList('favoris_lignes') ?? [];
      arretsFavoris = prefs.getStringList('favoris_arrets') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
if (lignesFavoris.isEmpty && arretsFavoris.isEmpty) {
    return const Text('Retrouve rapidement les infos de tes favoris (arrêts, lignes...)');
  }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(' Lignes favorites',
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        if (lignesFavoris.isEmpty)
          const Text('Aucune ligne en favori')
        else
          ...lignesFavoris
              .map((ligne) => ListTile(
                    leading: const Icon(Icons.train),
                    title: Text(ligne),
                  ))
              .toList(),
        const SizedBox(height: 16),
        const Text('Arrêts favoris',
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        if (arretsFavoris.isEmpty)
          const Text('Aucun arrêt en favori')
        else
          ...arretsFavoris
              .map((arret) => ListTile(
                    leading: const Icon(Icons.location_on),
                    title: Text(arret),
                  ))
              .toList(),
      ],
    );
  }
}
