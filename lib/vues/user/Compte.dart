import 'package:flutter/material.dart';
import '../../widgets/myBottomAppBar.dart';
import '../../widgets/myAppBar.dart';
class CompteScreen extends StatelessWidget {
  const CompteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(currentIndex: 3),
        bottomNavigationBar:MyBottomAppBar(currentIndex: 3)
,
      backgroundColor: const Color(0xFFF6F7FB),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Connexion
            ListTile(
              leading: const Icon(Icons.person_outline, size: 32),
              title: const Text("Se connecter / S’inscrire",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              onTap: () {Navigator.pushNamed(context,'/login');
                // Naviguer vers la page de connexion
              },
            ),
            const SizedBox(height: 16),

            const Text("monSNCT",
                style: TextStyle(
                    fontWeight: FontWeight.w500, color: Colors.grey)),

            const SizedBox(height: 12),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  )
                ],
              ),
              child: Column(
                children: const [
                  
                  _OptionItem(
                    icon: Icons.qr_code,
                    label: "Mes données personnelles",
                  ),
                  _OptionItem(
                    icon: Icons.lock_outline,
                    label: "Changer de mot de passe",
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OptionItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _OptionItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[700]),
      title: Text(label),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        // Navigue vers la page concernée
      },
    );
  }
}
