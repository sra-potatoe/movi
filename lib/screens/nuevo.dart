import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class NewScreen extends StatefulWidget {
  const NewScreen({Key? key}) : super(key: key);

  @override
  State<NewScreen> createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: phoneNumberController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(labelText: 'Número de teléfono'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: messageController,
              decoration: InputDecoration(labelText: 'Mensaje'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Aquí puedes implementar la lógica para enviar el mensaje.
                sendSMS();
              },
              child: Text('Enviar Mensaje'),
            ),
          ],
        ),
      ),
    );
  }

  void sendSMS() async {
    String phoneNumber = phoneNumberController.text;
    String message = messageController.text;

    String url = 'sms:$phoneNumber?body=$message';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // No se puede abrir la aplicación de mensajes.
      // Puedes manejar este caso según tus necesidades.
      print('No se puede abrir la aplicación de mensajes.');
    }
  }
}
