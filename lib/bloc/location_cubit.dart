import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<locationState> {
  LocationCubit() : super(LocationInitial());

  Future<void> GetLocation() async {
    DartPluginRegistrant.ensureInitialized();
    LocationPermission permission =
        await Geolocator.checkPermission(); //get lat and long
    if (permission != LocationPermission.denied ||
        permission != LocationPermission.deniedForever) {
      emit(const LocationLoading());
      try {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.medium,
        );
        emit(LocationLoaded(
            latitude: position.latitude,
            longitude: position.longitude));
      } catch (error) {
        print(error.toString());
        emit(LocationError(error: error.toString()));
      }
    }
  }
}
