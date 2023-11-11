import 'package:location/location.dart';

class FavoriteLocationState {
  final List<Location> favoriteLocations;

  FavoriteLocationState(this.favoriteLocations);

  FavoriteLocationState.empty() : favoriteLocations = [];
}

class FavoriteLocationAdded extends FavoriteLocationState {
  FavoriteLocationAdded() : super.empty();
}

class FavoriteLocationInitial extends FavoriteLocationState {
  FavoriteLocationInitial() : super.empty();
}

class FavoriteLocationLoaded extends FavoriteLocationState {
  FavoriteLocationLoaded(List<Map<String, dynamic>> favoriteLocations) : super(favoriteLocations.cast<Location>());
}