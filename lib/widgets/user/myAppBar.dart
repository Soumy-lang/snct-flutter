import 'package:flutter/material.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

@override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
 
@override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {


  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor:Colors.white,
      elevation: 2,
      leading: Padding(
        padding: const EdgeInsets.all(0.8),
        child:Image.asset(
          'images/logo.png',
          fit:BoxFit.contain,
          height: 40,
          ),
      ),
      title: Text('CHINA',
      style: TextStyle(color: Colors.black, fontSize: 11),
      ),
      centerTitle: false,
    );
  }
}
