import 'package:flutter/material.dart';
import 'titres/shopping_bag.dart';
class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  final int currentIndex;
  const MyAppBar({super.key,required this.currentIndex});

@override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight+48);
 
@override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
void _openCart(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => const CartSheet(),
  );
}


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
      bottom: widget.currentIndex == 1
          ? const TabBar(
              tabs: [
                Tab(text: 'Les lignes'),
                Tab(text: 'Les arrêts'),
              ],
            )
          : widget.currentIndex == 2?
          const TabBar(
            tabs: [
              Tab(text: 'Acheter'),
              Tab(text: 'Mes titres')
            ]
          ) 
          :null,
          actions: [
    if (widget.currentIndex == 2)
      IconButton(
        icon: const Icon(Icons.shopping_bag, color: Colors.black),
        onPressed: () =>_openCart(context),
      ),
  ],
      title: Text('CHINA',
      style: TextStyle(color: Colors.black, fontSize: 11),
      ),
      centerTitle: false,
    );
  }
}
