import 'package:flutter/material.dart';
import '../widgets/myBottomAppBar.dart';
import '../widgets/myAppBar.dart';
import '../widgets/bodyContain.dart';

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      bottomNavigationBar: MyBottomAppBar(),
      body: MybodyContain(),
    );
  }
}
