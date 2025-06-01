import 'package:flutter/material.dart';
import 'package:snct_app/routes/routes.dart';
import 'package:provider/provider.dart';
import 'routes/route.dart'; 
import './widgets/titres/cart_provider.dart';


void main()  {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'SNCT',
      debugShowCheckedModeBanner: false,
      initialRoute: '/admin',
      routes: appRoutes,

    );
  }
}