import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_ex/screens/map/usereditdata.dart';

class UserData extends StatefulWidget {
  const UserData({Key? key}) : super(key: key);

  @override
  _UserDataState createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final User? user = auth.currentUser;
    final uid = user != null ? user.uid : '';

    return Scaffold(
      appBar: AppBar(
        title: Text('Datos del usuario'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('usuarios')
            .doc(uid)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Algo salió mal');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          Map<String, dynamic> data =
              snapshot.data!.data()! as Map<String, dynamic>;
          return ListView(
            children: [
              ListTile(
                title: Text('Nombre: ${data['nombre']}'),
              ),
              ListTile(
                title: Text('Apellido: ${data['apellido']}'),
              ),
              ListTile(
                title: Text('Correo: ${data['correo']}'),
              ),
              // Agrega más campos aquí
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DataEdit()));
                },
                child: Text('Cambiar datos'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.pink),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
