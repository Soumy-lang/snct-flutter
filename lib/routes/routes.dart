// lib/routes/routes.dart
import 'package:flutter/material.dart';

import '../vues/userView.dart';

class AppRoutes {
  static const String uservues = '/user';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case uservues:
        return MaterialPageRoute(builder: (_) => UserPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Page non trouvée')),
          ),
        );
    }
  }
}
