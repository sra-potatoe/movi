import 'package:flutter_ex/screens/map/BLoC/FavoriteLocationEvent.dart';

class AddFavoriteLocation extends FavoriteLocationEvent {

  final double latitude;
  final double longitude;

  AddFavoriteLocation({required this.latitude, required this.longitude});
}

