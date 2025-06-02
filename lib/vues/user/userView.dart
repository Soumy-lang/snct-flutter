import 'package:flutter/material.dart';
import '../../widgets/user/myBottomAppBar.dart';
import '../../widgets/user/myAppBar.dart';
import '../../widgets/user/Accueil/bodyContain.dart';

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
