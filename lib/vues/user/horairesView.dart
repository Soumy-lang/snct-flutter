import 'package:flutter/material.dart';
import '../../widgets/myBottomAppBar.dart';
import '../../widgets/myAppBar.dart';
import '../../widgets/horaire/bodyContain.dart';

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
