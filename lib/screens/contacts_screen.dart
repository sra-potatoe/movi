import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';

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
    final intent = AndroidIntent(
        action: 'action_view',
        data: Uri.encodeFull(url),
        package: 'com.android.phone');
    intent.launch();
  }
}
