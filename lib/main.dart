import 'package:flutter/material.dart';
import 'routes/route.dart'; 
import 'package:snct_app/vues/login.dart';
import 'package:snct_app/vues/register.dart';

void main()  {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SNCT Admin',
      debugShowCheckedModeBanner: false,
      initialRoute: '/register',
      routes: appRoutes,
    );
  }
}
