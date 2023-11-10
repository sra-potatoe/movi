import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'main_screen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_core/firebase_core.dart';

//import 'firebase_options.dart';
import 'signup_screen.dart';

class LoginScreen extends StatelessWidget {
  final _auth = FirebaseAuth.instance;

  // Controladores para los campos de entrada
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<String?> _getUsername(String? uid) async {
    if (uid != null) {
      try {
        final userDoc = await FirebaseFirestore.instance
            .collection('usuarios')
            .doc(uid)
            .get();
        if (userDoc.exists) {
          return userDoc.get('nombre');
        }
      } catch (e) {
        print('Error al obtener el nombre de usuario: $e');
      }
    }
    return null;
  }

  void loginUser(BuildContext context) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      if (userCredential.user != null) {
        final user = userCredential.user;
        final username = await _getUsername(user?.uid);

        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Bienvenido, ${username ?? 'usuario'}'),
              content: Text('Inicio de sesión exitoso.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MainScreen()));
                  },
                  child: Text('Aceptar'),
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error de inicio de sesión'),
              content: Text(
                  'El inicio de sesión ha fallado. Por favor, verifica tus credenciales.'),
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
    } catch (e) {
      print(e);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error de inicio de sesión'),
            content: Text(
                'El inicio de sesión ha fallado. Por favor, verifica tus credenciales.'),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Iniciar Sesión'),
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Inicia Sesión',
              style: TextStyle(
                fontSize: 24,
                color: const Color.fromARGB(255, 69, 68, 68),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Correo Electrónico',
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
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                loginUser(context);
              },
              child: Text('Iniciar Sesión'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.pink),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignupScreen()));
              },
              child: Text('No tengo una cuenta'),
            ),
          ],
        ),
      ),
    );
  }
}
