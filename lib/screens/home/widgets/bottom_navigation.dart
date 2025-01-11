import 'package:flutter/material.dart';
import 'package:money_manager/screens/home/screen_home.dart';

class MMBottomNavigation extends StatelessWidget {
  const MMBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ScreenHome.selectIndex,
      builder: (BuildContext ctx,int updatedIndex, Widget? _)
      {
        return BottomNavigationBar(
         selectedItemColor: const Color.fromARGB(255, 163, 20, 189),
         unselectedItemColor: const Color.fromARGB(255, 198, 195, 195),
         currentIndex: updatedIndex,
         onTap: (newIndex)
         {
          ScreenHome.selectIndex.value=newIndex;
         },
         items: 
         const 
         [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home',), 
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Categories',),
         ], 
        );
      } 
    );
  }
}