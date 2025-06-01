import 'package:flutter/material.dart';
import 'package:snct_app/routes/routes.dart';
import 'package:provider/provider.dart';

import './widgets/titres/cart_provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: const MyApp(),
    ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SNCT',
      initialRoute: AppRoutes.uservues,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
