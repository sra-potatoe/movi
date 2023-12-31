import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactsScreen extends StatelessWidget {
  final CollectionReference contactosCollection =
      FirebaseFirestore.instance.collection('contactos_confianza');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: contactosCollection.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final contactos = snapshot.data!.docs;

          return ListView.builder(
            itemCount: contactos.length,
            itemBuilder: (context, index) {
              final contacto = contactos[index];
              final nombre = contacto['nombre'] ?? '';
              final apellido = contacto['apellido'] ?? '';
              final telefono = contacto['telefono'] ?? '';

              return Card(
                child: ListTile(
                  title: Text('$nombre $apellido'),
                  subtitle: Text('Teléfono: $telefono'),
                  trailing: ElevatedButton(
                    onPressed: () {
                      _makePhoneCall(context, telefono);
                    },
                    child: Text('Llamar'),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  // Función para abrir la aplicación de teléfono con el número copiado
  void _makePhoneCall(BuildContext context, String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // Encontrar el Scaffold más cercano y mostrar la SnackBar
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('No se pudo abrir la aplicación de teléfono.'),
        duration: Duration(seconds: 3),
      ));
    }
  }
}
