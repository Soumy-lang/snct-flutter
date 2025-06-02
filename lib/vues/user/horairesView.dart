import 'package:flutter/material.dart';
import '../../widgets/user/myBottomAppBar.dart';
import '../../widgets/user/myAppBar.dart';
import '../../widgets/user/horaire/bodyContain.dart';
import '../../services/user/ligne_service.dart';


/*class HorrairePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      bottomNavigationBar: MyBottomAppBar(currentIndex: 1),
      body: Title(color: Colors.red, child: Text('couou')),
    );
  }
}*/

class HorairesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color(0xFFEAF0FF),
        appBar: MyAppBar(currentIndex: 1,),
        body: const TabBarView(
          children: [
            LignesTab(),
            ArretsTab(),
          ],
        ),
        bottomNavigationBar:MyBottomAppBar(currentIndex: 1)
      ),
    );
  }
}
