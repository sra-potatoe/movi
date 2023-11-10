import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'firebase_options.dart';

class SignupScreen extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _showWelcomeDialog(BuildContext context, String username) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Bienvenido, $username'),
          content: Text('El registro se ha completado con éxito.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MainScreen()),
                );
              },
              child: Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showErrorDialog(
      BuildContext context, String errorMessage) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error de registro'),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  void registerUser(BuildContext context) async {
    try {
      final newUser = await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      if (newUser != null) {
        final uid = newUser.user!.uid;
        final username = usernameController.text;

        await _firestore.collection('usuarios').doc(uid).set({
          'apellido': lastNameController.text,
          'correo': emailController.text,
          'nombre': nameController.text,
          'nombreUsuario': username,
          'password': passwordController.text,
        });

        _showWelcomeDialog(context, username);
      } else {
        _showErrorDialog(
          context,
          'El registro ha fallado. Por favor, inténtalo de nuevo.',
        );
      }
    } catch (e) {
      print(e);
      _showErrorDialog(
        context,
        'El registro ha fallado. Por favor, verifica tus credenciales.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Cuenta'),
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
            Text(
              'Crea tu Cuenta',
              style: TextStyle(
                fontSize: 24,
                color: const Color.fromARGB(255, 18, 18, 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      labelText: 'Nombre de Usuario',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Nombre',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: lastNameController,
                    decoration: InputDecoration(
                      labelText: 'Apellido',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Correo',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      registerUser(context);
                    },
                    child: Text('Crear Cuenta'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.pink),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
