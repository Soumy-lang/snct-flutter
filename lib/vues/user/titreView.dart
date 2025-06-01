import 'package:flutter/material.dart';
import '../../widgets/myBottomAppBar.dart';
import '../../widgets/myAppBar.dart';
import '../../widgets/titres/bodyContain.dart';

/*class TitrePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(currentIndex: 2,),
      bottomNavigationBar: MyBottomAppBar(currentIndex: 2),
      body: Title(color: Colors.green, child: Text("dddedcdc")),
    );
  }
}*/

class AchatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
       appBar: MyAppBar(currentIndex: 2,),

        body: const TabBarView(
          children: [
            AcheterTab(),
            Center(child: Text("Mes titres ici")),
          ],
        ),
        bottomNavigationBar:MyBottomAppBar(currentIndex: 2),
      ),
    );
  }
}
