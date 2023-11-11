import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/contact_data_screen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart'; // Importa la pantalla de inicio de sesión

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/', // Define la ruta inicial
      routes: {
        '/': (context) =>
            LoginScreen(), // Asigna LoginScreen como la página inicial
        '/signup': (context) => SignupScreen(),
        '/contact_data': (context) => ContactDataScreen(),
        // '/': (context) => NewContactScreen(),
        //'/new_contact': (context) =>   NewContactScreen(),
      },
    );
  }
}
