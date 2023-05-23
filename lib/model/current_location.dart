class CurrentLocation {
  CurrentLocation({
    required this.latitude,
    required this.longitude,
    required this.nameLocation,
    required this.currentTime,
    required this.temp,
    required this.feelLikeTemp,
    required this.sunriseTime,
    required this.sunsetTime,
  });

  final double latitude;
  final double longitude;
  final String nameLocation;
  final int currentTime;
  final int sunriseTime;
  final int sunsetTime;
  final double temp;
  final double feelLikeTemp;


}
