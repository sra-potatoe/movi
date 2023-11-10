import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DateMap extends StatefulWidget {
  const DateMap({Key? key}) : super(key: key);

  @override
  _DateMapState createState() => _DateMapState();
}

class _DateMapState extends State<DateMap> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ubicaciones favoritas')),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('ubicacion').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var location = snapshot.data!.docs[index];
              var ubicacion = location['ubicacion'];
              return Card(
                child: ListTile(
                  title: Text('Ubicación favorita ${index + 1}'),
                  subtitle: Text(
                      'Latitud: ${ubicacion['latitud']}, Longitud: ${ubicacion['longitud']}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      await location.reference.delete();
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
