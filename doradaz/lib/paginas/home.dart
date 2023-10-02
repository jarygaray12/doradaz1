import 'profile_view.dart';
import 'package:flutter/material.dart';
import 'arepa.dart';
import 'empanada.dart';

class Home extends StatefulWidget {
  const Home({Key? key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    ArepaPage(),
    EmpanadaPage(),
    ProfileView(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Store Frito',
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
        backgroundColor: Colors.orange,
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onTabTapped,
        currentIndex: _currentIndex,
        backgroundColor: Colors.orange,
        selectedItemColor: const Color.fromARGB(255, 255, 28, 28),
        unselectedItemColor: Color.fromARGB(255, 255, 255, 255),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
            label: 'Arepa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_pizza),
            label: 'Empanada',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Tu',
          ),
        ],
      ),
    );
  }
}
