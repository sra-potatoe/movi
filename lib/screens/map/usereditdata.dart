import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DataEdit extends StatefulWidget {
  const DataEdit({Key? key}) : super(key: key);

  @override
  _DataEditState createState() => _DataEditState();
}

class _DataEditState extends State<DataEdit> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  late String _nombre, _apellido, _correo;

  @override
  Widget build(BuildContext context) {
    final User? user = auth.currentUser;
    final uid = user != null ? user.uid : '';

    return Scaffold(
      appBar: AppBar(
        title: Text('Editar datos del usuario'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Nombre'),
              onSaved: (value) {
                _nombre = value!;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Apellido'),
              onSaved: (value) {
                _apellido = value!;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Correo'),
              onSaved: (value) {
                _correo = value!;
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  FirebaseFirestore.instance
                      .collection('usuarios')
                      .doc(uid)
                      .update({
                    'nombre': _nombre,
                    'apellido': _apellido,
                    'correo': _correo,
                  });
                }
              },
              child: Text('Guardar cambios'),
            ),
          ],
        ),
      ),
    );
  }
}
