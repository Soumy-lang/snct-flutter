import 'package:flutter/material.dart';
import '../../../widgets/myBottomAppBar.dart';
import '../../../widgets/myAppBar.dart';
import '../../widgets/Accueil/bodyContain.dart';

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(currentIndex: 0,),
      bottomNavigationBar: MyBottomAppBar(currentIndex: 0),
      body: MybodyContain(),
    );
  }
}
