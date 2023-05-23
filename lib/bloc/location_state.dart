part of 'location_cubit.dart';


class locationState extends Equatable {
  const locationState(); // constructor
  @override
  List<Object> get props => []; // props
}

class LocationInitial extends locationState{
  const LocationInitial();
}

class LocationLoaded extends locationState {
  final double latitude;
  final double longitude;

  LocationLoaded({required this.latitude, required this.longitude});

  @override
  List<Object> get props => [latitude, longitude];
}

class LocationLoading extends locationState{
  const LocationLoading();
}

class LocationError extends locationState{
  final String error;
  const LocationError({required this.error});
  @override
  List<Object> get props => [error];
}
