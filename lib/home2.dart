import 'package:flutter/material.dart';
import 'package:to_dos/home.dart';
import 'package:to_dos/upcoming.dart';


class Home2 extends StatefulWidget {
  @override
  _Home2State createState() => _Home2State();
}

class _Home2State extends State<Home2> {
  int _selectedIndex = 0;
    static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  
  @override
  Widget build(BuildContext context) {
       return Scaffold(
      body: Center(
        child: [
          
          Home(),
          Up()
        ].toList().elementAt(_selectedIndex),
      ),
       bottomNavigationBar: BottomNavigationBar(
        //  fixedColor: Colors.red,

         type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',activeIcon: Icon(Icons.home_outlined)
        ),
       
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: 'Upcoming',
          activeIcon: Icon(Icons.chat_bubble_outline)
          // title: Text('sss')
        ),
      
      ],
      currentIndex: _selectedIndex,
      unselectedItemColor: Colors.white,
      selectedItemColor: Colors.blueAccent,
      onTap: _onItemTapped,
      backgroundColor: Color(0xff232526),
    ),
    );
  }
}