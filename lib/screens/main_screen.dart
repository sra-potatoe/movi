import 'package:flutter/material.dart';
import 'package:flutter_ex/screens/map/map.dart';
import 'package:flutter_ex/screens/nuevo.dart';
import 'contacts_screen.dart';
import 'add_contacts_screen.dart';
import 'add_personal_data_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    ContactsScreen(),
    AddContactsScreen(),
    MyMap(),
    NewScreen(),
    AddPersonalDataScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tus Contactos de Confianza'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.pink, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts),
            label: 'Mis Contactos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Añadir Contactos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Añadir Mis Datos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Mapa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Mapa',
          ),
        ],
      ),
    );
  }
}
