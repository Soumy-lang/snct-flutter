import 'package:flutter/material.dart';
import 'routes/route.dart'; 
import 'package:provider/provider.dart';
import './widgets/user/titres/cart_provider.dart';


void main()  {
  runApp( MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],child: MyApp()));
  // runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'SNCT',
      debugShowCheckedModeBanner: false,
      initialRoute: '/user',
      routes: appRoutes,

    );
  }
}