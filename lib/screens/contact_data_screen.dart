import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'contact_insert_screen.dart'; // Importa la pantalla de inserción de nuevo contacto

class ContactDataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tus Contactos de Confianza'),
        backgroundColor: Colors.pink,
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ContactInsertScreen()),
              );
            },
            child: Text('+ Añadir Nuevo Contacto'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.pink),
            ),
          ),
        ],
      ),
    );
  }
}
