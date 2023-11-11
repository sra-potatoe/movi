// members_screen.dart
import 'package:flutter/material.dart';

class MembersScreen extends StatefulWidget {
  @override
  _MembersScreenState createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  final List<Map<String, dynamic>> dataList = [
    {
      'nombre': 'Carlo Andres Lopez Fuentes',
      'correo': 'jlfc6000468@est.univalle.edu',
      'imagen': 'https://placekitten.com/80/80',
    },
    {
      'nombre': 'Bruno Ferrufino Mercado',
      'correo': 'fmb6000615@est.univalle.edu',
      'imagen': 'https://placekitten.com/80/80',
    },
    {
      'nombre': 'Yannel Erika Hinojosa Cabrera',
      'correo': 'hcy6000567@est.univalle.edu',
      'imagen': 'https://placekitten.com/80/80',
    },
    {
      'nombre': 'Sergio Martin Escalante Cisneros',
      'correo': 'ecs6000308@est.univalle.edu',
      'imagen': 'https://placekitten.com/80/80',
    },
    {
      'nombre': 'Jhon Samuel Vedia Fajardo',
      'correo': 'vfj6000392@est.univalle.edu',
      'imagen': 'https://placekitten.com/80/80',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: dataList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(dataList[index]['imagen']),
              ),
              title: Text(dataList[index]['nombre']),
              subtitle: Text(dataList[index]['correo']),
            ),
          );
        },
      ),
    );
  }
}
