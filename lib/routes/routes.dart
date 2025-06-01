// lib/routes/routes.dart
import 'package:flutter/material.dart';
import '../vues/user/horairesView.dart';
import '../vues/user/userView.dart';
import '../vues/user/titreView.dart';
import '../vues/user/ResultatsTrajetPage.dart';

class AppRoutes {
  static const String uservues = '/user';
  static const String horaires = '/horaires';
  static const String titres = '/titres';
  static const String resultTrajet ='/resultTrajet';



  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case uservues:
        return MaterialPageRoute(builder: (_) => UserPage());
        /*case resultTrajet:
        return MaterialPageRoute(builder: (_) => TrajetPage_results());*/
      case titres:
        return MaterialPageRoute(builder: (_) => AchatPage());
      case horaires:
        return MaterialPageRoute(builder: (_) => HorairesPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Page non trouvée')),
          ),
        );
    }
  }
}
