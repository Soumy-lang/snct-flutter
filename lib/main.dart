import 'package:flutter/material.dart';
import 'routes/route.dart'; 

void main()  {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SNCT',
      debugShowCheckedModeBanner: false,
      initialRoute: '/register',
      routes: appRoutes,
    );
  }
}