import 'package:location/location.dart';

abstract class FavoriteLocationEvent {}

class AddFavoriteLocation extends FavoriteLocationEvent {
  final double latitude;
  final double longitude;

  AddFavoriteLocation({required this.latitude, required this.longitude});
}

class RemoveFavoriteLocation extends FavoriteLocationEvent {
  final Location location;

  RemoveFavoriteLocation(this.location);
}

class FavoriteLocationList extends FavoriteLocationEvent {}

