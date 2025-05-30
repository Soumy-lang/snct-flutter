import 'package:flutter/material.dart';
import 'package:snct_app/routes/routes.dart';
import 'vues/user/userView.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context){
    return MaterialApp(
    debugShowCheckedModeBanner: false,
    title:'SNCT',
    initialRoute: AppRoutes.uservues,
    onGenerateRoute:AppRoutes.generateRoute,
  );
}}

