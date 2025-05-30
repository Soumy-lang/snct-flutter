// lib/routes/routes.dart
import 'package:flutter/material.dart';
import '../vues/user/horrairesView.dart';
import '../vues/user/userView.dart';

class AppRoutes {
  static const String uservues = '/user';
  static const String horaires = '/horaires';


  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case uservues:
        return MaterialPageRoute(builder: (_) => UserPage());
      case horaires:
        return MaterialPageRoute(builder: (_) => HorrairePage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Page non trouvée')),
          ),
        );
    }
  }
}
