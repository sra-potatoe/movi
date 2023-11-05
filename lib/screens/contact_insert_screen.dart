import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContactInsertScreen extends StatelessWidget {
  final nombreController = TextEditingController();
  final apellidoController = TextEditingController();
  final telefonoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inserción de Datos de Contacto'),
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nombreController,
              decoration: InputDecoration(
                labelText: 'Nombre',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: apellidoController,
              decoration: InputDecoration(
                labelText: 'Apellido',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: telefonoController,
              decoration: InputDecoration(
                labelText: 'Teléfono',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final nombre = nombreController.text;
                final apellido = apellidoController.text;
                final telefono = telefonoController.text;

                if (nombre.isNotEmpty &&
                    apellido.isNotEmpty &&
                    telefono.isNotEmpty) {
                  try {
                    final contactosCollection = FirebaseFirestore.instance
                        .collection('contactos_confianza');

                    await contactosCollection.add({
                      'nombre': nombre,
                      'apellido': apellido,
                      'telefono': telefono,
                    });

                    nombreController.clear();
                    apellidoController.clear();
                    telefonoController.clear();

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Contacto agregado con éxito.'),
                      duration: Duration(seconds: 3),
                    ));
                  } catch (e) {
                    print('Error al guardar los datos: $e');
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Todos los campos son obligatorios.'),
                    duration: Duration(seconds: 3),
                  ));
                }
              },
              child: Text('Guardar Datos'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.pink),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
