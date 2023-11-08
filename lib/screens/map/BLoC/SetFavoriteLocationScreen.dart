import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ex/screens/map/BLoC/FavoriteLocationEvent.dart';
import 'FavoriteLocationBloc.dart';

class SetFavoriteLocationScreen extends StatelessWidget {
  final FavoriteLocationBloc favoriteLocationBloc;
  
  final double latitud;
  final double longitud;
  final String uid; // Asegúrate de tener el uid del usuario

  const SetFavoriteLocationScreen({
    required this.favoriteLocationBloc,
    required this.latitud,
    required this.longitud,
    required this.uid, // Asegúrate de pasar el uid del usuario
  });
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ubicaciones favoritas')),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('usuarios').doc(uid).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Algo salió mal');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Cargando");
          }

          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            if (data['ubicacionFavorita'] != null) {
              return ListTile(
                title: Text('Ubicación favorita: Latitud ${data['ubicacionFavorita']['latitud']}, Longitud ${data['ubicacionFavorita']['longitud']}'),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    context.read<FavoriteLocationBloc>().add(RemoveFavoriteLocation(data['ubicacionFavorita']));
                  },
                ),
              );
            } else {
              return Text('No se ha establecido ninguna ubicación favorita.');
          }

        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseFirestore.instance.collection('usuarios').doc(uid).update({
            'ubicacionFavorita': {
              'latitud': latitud,
              'longitud': longitud,
            },
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
  
}
