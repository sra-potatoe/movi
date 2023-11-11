import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ex/screens/map/BLoC/FavoriteLocationEvent.dart';
import 'package:flutter_ex/screens/map/BLoC/FavoriteLocationState.dart';
import 'package:bloc/bloc.dart';

class FavoriteLocationBloc extends Bloc<FavoriteLocationEvent, FavoriteLocationState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String? uid;

  FavoriteLocationBloc({required this.uid}) : super(FavoriteLocationInitial()) {
    on<AddFavoriteLocation>((event, emit) async {
      // Guarda la ubicación favorita en Firestore
      await _firestore.collection('usuarios').doc(uid).update({
        'ubicacionFavorita': {
          'latitud': event.latitude,
          'longitud': event.longitude,
        },
      });
      emit(FavoriteLocationAdded());
    });
    on<FavoriteLocationList>((event, emit) async {
      // Lee las ubicaciones favoritas de Firestore
      final snapshot = await _firestore.collection('usuarios').doc(uid).get();

      final favoriteLocations = List<Map<String, dynamic>>.from(snapshot.data()?['ubicacionFavorita'] as List)
        .map((location) => {
              'latitude': location['latitud'],
              'longitude': location['longitud'],
            })
        .toList();

    emit(FavoriteLocationLoaded(favoriteLocations));  
    });
    // No olvides registrar y manejar otros eventos aquí, como RemoveFavoriteLocation
  }
  
}
