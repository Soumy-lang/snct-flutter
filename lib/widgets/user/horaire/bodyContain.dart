import 'package:flutter/material.dart';
import 'package:snct_app/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../services/user/ligne_service.dart';
import '../../../services/user/arret_service.dart';

class LignesTab extends StatefulWidget {
  const LignesTab();
@override
  State<LignesTab> createState() => _LignesTabState();
}

class _LignesTabState extends State<LignesTab> {
  final Set<String> favoris = {};
  final String _prefsKey = 'favoris_lignes';
  final LigneService ligneService = LigneService();
List<Map<String, dynamic>> lignes = [];
bool lignesLoaded = false;

Color _fromHex(String hexColor) {
  hexColor = hexColor.replaceAll("#", "");
  return Color(int.parse("FF$hexColor", radix: 16));
}

  

    String searchQuery = '';
  final TextEditingController searchController = TextEditingController();
@override
  void initState() {
    super.initState();
    _loadFavoris();
    _fetchAndStoreLignes();
  }

Future<void> _fetchAndStoreLignes() async {
  try {
    final result = await ligneService.fetchLignes();
    setState(() {
      
      lignes = result.map((ligne) => {
        'name': ligne['name'],
        'number': ligne['number'],
        'accessible': ligne['accessible'],
        'color': _fromHex(ligne['color']) // convertit hex vers Color
      }).toList();
      lignesLoaded = true;
    });
  } catch (e) {
    print('Erreur chargement des lignes : $e');
  }
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
if (!lignesLoaded) {
  return const Center(child: CircularProgressIndicator());
}

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
              onTap: () => _afficherArretsLigne(context, lignes['number']),
            )),
      ],
    );
  }
}

Future<void> _afficherArretsLigne(BuildContext context, String ligneName) async {
  try {
    final arrets = await ArretService().fetchArretsByLigneName(ligneName); // 👈 tu dois avoir cette méthode dans ton service
    if (arrets.isEmpty) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("Arrêts de la ligne $ligneName"),
          content: const Text("Aucun arrêt trouvé pour cette ligne."),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("Fermer")),
          ],
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Arrêts de la ligne $ligneName"),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: arrets.length,
            itemBuilder: (_, index) {
              final arret = arrets[index];
              return ListTile(
                title: Text(arret['name']),
                trailing: arret['accessible'] == true ? const Icon(Icons.accessible, size: 18) : null,
              );
            },
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Fermer")),
        ],
      ),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Erreur : $e")));
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
final ArretService arretService = ArretService();
List<Map<String, dynamic>> arrets = [];
bool arretsLoaded = false;



String searchQuery = '';
  final TextEditingController searchController = TextEditingController();
    @override
  void initState() {
    super.initState();
    _loadFavoris();
     _fetchArrets();
  }

Future<void> _fetchArrets() async {
  try {
    final result = await arretService.fetchArrets();
    setState(() {
      arrets = result;
      arretsLoaded = true;
    });
  } catch (e) {
    print('Erreur chargement arrets : $e');
  }
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
if (!arretsLoaded) {
  return const Center(child: CircularProgressIndicator());
}
if (arrets.isEmpty) {
  return const Center(child: Text("Aucun arrêt trouvé."));
}

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
  final VoidCallback onTap; 

  const LigneTile({required this.number, required this.color, required this.name, required this.accessible, required this.isFavorite, required this.onStarTap ,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
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
