import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ex/screens/map/BLoC/FavoriteLocationBloc.dart';
import 'package:flutter_ex/screens/map/BLoC/SetFavoriteLocationScreen.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyMap extends StatefulWidget {
  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  FirebaseAuth auth = FirebaseAuth.instance;
  String? uid;
  LatLng? _currentLocation;
  final _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void getCurrentUser() {
    final User? user = auth.currentUser;
    uid = user?.uid;
    print(uid);
  }

  Future<void> _getCurrentLocation() async {
    final locationData = await Location().getLocation();
    setState(() {
      _currentLocation = LatLng(
        locationData.latitude ?? 0.0,
        locationData.longitude ?? 0.0,
      );
    });
  }

  Future<void> _saveLocation() async {
    getCurrentUser();
    if (uid != null) {
      await _firestore.collection('usuarios').doc(uid).update({
        'ubicacionFavorita': {
          'latitud': _currentLocation?.latitude,
          'longitud': _currentLocation?.longitude,
        },
      });
      print(_currentLocation?.latitude);
      print(_currentLocation?.longitude);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentLocation == null
          ? Center(child: CircularProgressIndicator())
          : FlutterMap(
              options: MapOptions(
                center: _currentLocation,
                zoom: 13.0,
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayerOptions(
                  markers: [
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: _currentLocation!,
                      builder: (ctx) => Container(
                        child: Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 40.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _saveLocation();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => FavoriteLocationBloc(uid: uid),
                child: SetFavoriteLocationScreen(
                  favoriteLocationBloc: FavoriteLocationBloc(uid: uid),
                  latitud: _currentLocation?.latitude ?? 0.0,
                  longitud: _currentLocation?.longitude ?? 0.0,  // Pasar el uid al SetFavoriteLocationScreen
                ),
              ),
            ),
          );
        },
        child: Icon(Icons.save),
      ),

    );
  }
}
