import 'package:flutter/material.dart';

class MyBottomAppBar extends StatefulWidget {
  @override
  State<MyBottomAppBar> createState() => _MyBottomAppBarState();
}

class _MyBottomAppBarState extends State<MyBottomAppBar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.black,
      child: SafeArea( 
        top: false,
        child: Row(
          
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home, 'Accueil', isActive: true),
              _buildNavItem(Icons.directions_transit, 'Horaires'),
              _buildNavItem(Icons.confirmation_num, 'Mes titres'),
              
              _buildNavItem(Icons.menu, 'Plus'),
            ],
          
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, {bool isActive = false}) {
    return Expanded(
      child: Column(
      
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
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
      
      )
    );
  }
}
