import 'package:flutter/material.dart';
import '../vues/user/userView.dart';
import '../vues/user/horairesView.dart';
import '../vues/user/titreView.dart';
import '../vues/user/Compte.dart';

class MyBottomAppBar extends StatelessWidget {
  final int currentIndex;

  const MyBottomAppBar({required this.currentIndex});

  void _navigateWithFade(BuildContext context, Widget page) {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => page,
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: Duration(milliseconds: 300),
      ),
    );
  }

  void _onTabTapped(BuildContext context, int index) {
    if (index == currentIndex) return;

    switch (index) {
      case 0:
        _navigateWithFade(context, UserPage());
        break;
      case 1:
        _navigateWithFade(context, HorairesPage());
        break;
      case 2:
        _navigateWithFade(context, AchatPage());
        break;
      case 3:
        _navigateWithFade(context, CompteScreen()); // ou ta page "Plus"
        break;
    }
  }

  Widget _buildNavItem(BuildContext context, IconData icon, String label, int index) {
    bool isActive = currentIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => _onTabTapped(context, index),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 24,
                color: isActive ? Colors.orange : Colors.white,
              ),
              SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: isActive ? Colors.orange : Colors.white,
                  fontSize: 11,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.black,
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(context, Icons.home, 'Accueil', 0),
            _buildNavItem(context, Icons.directions_transit, 'Horaires', 1),
            _buildNavItem(context, Icons.confirmation_num, 'Mes titres', 2),
            _buildNavItem(context, Icons.menu, 'Plus', 3),
          ],
        ),
      ),
    );
  }
}
