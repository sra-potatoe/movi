import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ex/screens/map/BLoC/FavoriteLocationEvent.dart';
import 'package:flutter_ex/screens/map/BLoC/FavoriteLocationState.dart';
import 'FavoriteLocationBloc.dart';


class SetFavoriteLocationScreen extends StatelessWidget {
  final FavoriteLocationBloc favoriteLocationBloc;
  final double latitud;
  final double longitud;

  const SetFavoriteLocationScreen({
    required this.favoriteLocationBloc,
    required this.latitud,
    required this.longitud,
  });
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ubicaciones favoritas')),
      body: BlocBuilder<FavoriteLocationBloc, FavoriteLocationState>(
        bloc: favoriteLocationBloc,
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.favoriteLocations.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('Ubicación favorita ${index + 1}'),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    context.read<FavoriteLocationBloc>().add(RemoveFavoriteLocation(state.favoriteLocations[index]));
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<FavoriteLocationBloc>().add(AddFavoriteLocation(latitude: latitud,longitude: longitud));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}