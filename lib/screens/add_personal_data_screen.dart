import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ex/screens/map/useredit.dart';

class AddPersonalDataScreen extends StatelessWidget {
  final CollectionReference misDatosCollection =
      FirebaseFirestore.instance.collection('misdatos');

  final TextEditingController ciController = TextEditingController();
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController apellidoController = TextEditingController();
  final TextEditingController fechaNacController = TextEditingController();
  final TextEditingController tipoController = TextEditingController();

  void _addMisDatos(BuildContext context) async {
    final ci = ciController.text;
    final nombre = nombreController.text;
    final apellido = apellidoController.text;
    final fechaNac = fechaNacController.text;
    final tipo = tipoController.text;

    if (ci.isNotEmpty &&
        nombre.isNotEmpty &&
        apellido.isNotEmpty &&
        fechaNac.isNotEmpty &&
        tipo.isNotEmpty) {
      try {
        await misDatosCollection.add({
          'CI': ci,
          'nombre': nombre,
          'apellido': apellido,
          'fechanac': fechaNac,
          'tipo': tipo,
        });

        ciController.clear();
        nombreController.clear();
        apellidoController.clear();
        fechaNacController.clear();
        tipoController.clear();

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Datos personales guardados con éxito.'),
          duration: Duration(seconds: 3),
        ));
      } catch (e) {
        print('Error al guardar los datos personales: $e');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Ocurrió un error al guardar los datos personales.'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Eliminamos la propiedad appBar para quitar la AppBar
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: ciController,
              decoration: InputDecoration(
                labelText: 'CI',
              ),
            ),
            SizedBox(height: 10),
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
              controller: fechaNacController,
              decoration: InputDecoration(
                labelText: 'Fecha de Nacimiento',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: tipoController,
              decoration: InputDecoration(
                labelText: 'Tipo',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _addMisDatos(context);
              },
              child: Text('Guardar Datos Personales'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.pink),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UserData()));
              },
              child: Text('Ver Dato personales'),
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
