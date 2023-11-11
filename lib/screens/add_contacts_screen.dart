import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddContactsScreen extends StatelessWidget {
  final nombreController = TextEditingController();
  final apellidoController = TextEditingController();
  final telefonoController = TextEditingController();
  final contactosCollection =
      FirebaseFirestore.instance.collection('contactos_confianza');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
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
              onPressed: () {
                _addContact(context);
              },
              child: Text('Añadir Contacto'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.pink),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addContact(BuildContext context) async {
    final nombre = nombreController.text;
    final apellido = apellidoController.text;
    final telefono = telefonoController.text;

    if (nombre.isNotEmpty && apellido.isNotEmpty && telefono.isNotEmpty) {
      try {
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
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Ocurrió un error al agregar el contacto.'),
          duration: Duration(seconds: 3),
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Todos los campos son obligatorios.'),
        duration: Duration(seconds: 3),
      ));
    }
  }
}
