import 'package:flutter/material.dart';
import '../../widgets/user/myBottomAppBar.dart';
import '../../widgets/user/myAppBar.dart';
import '../../widgets/user/bodyContain.dart';
import '../../services/user/ligne_service.dart';


class HorrairePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      bottomNavigationBar: MyBottomAppBar(),
      body: MybodyContain(),
    );
  }
}
