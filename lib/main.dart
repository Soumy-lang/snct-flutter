import 'package:flutter/material.dart';
import './vues/userView.dart';


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
    
    home:UserPage()
  );
}}

