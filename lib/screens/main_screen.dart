import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:weather_glassmorph/screens/currentWeatherInfo.dart';
import '../bloc/location_cubit.dart';
import '../constants.dart';
import '../network_helper.dart';

class mainInfo extends StatefulWidget {
  const mainInfo({Key? key}) : super(key: key);

  @override
  State<mainInfo> createState() => _mainInfoState();
}

class _mainInfoState extends State<mainInfo> {
  List<String>? _address;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<List<String>> getNewLocation(double latitude, double longitude) async {
    List<Placemark> location = await placemarkFromCoordinates(
        latitude, longitude,
        localeIdentifier: "en");
    Placemark placeMark = location[0];
    String name = placeMark.country!;
    String subLocality = placeMark.subLocality!;
    String locality = placeMark.locality!;
    String address = " $locality, $subLocality";
    return [name, locality, subLocality];
  }

  Future<List<dynamic>> GetData(
      {required double latitude1,
      required double longitude1,
      required List<dynamic> result,
      required List<dynamic> resultForecast,
      required List<dynamic> resultHourly}) async {
    String nameLocation;
    int currentTime;
    int sunriseTime;
    int sunsetTime;
    int pressure;
    int humidity;
    int visibility;
    int windDeg;
    List<dynamic> iconId;
    double temp;
    double feelLikeTemp;
    double longitude;
    double latitude;
    dynamic uvi;
    double windSpeed;
    String urlCurrent =
        "https://api.openweathermap.org/data/2.5/onecall?lat=$latitude1&lon=$longitude1&units=metric&lang=ru&exclude=daily&appid=$key";
    String urlForecast =
        "https://api.openweathermap.org/data/2.5/forecast?cnt=36&lat=$latitude1&lon=$longitude1&units=metric&lang=ru&appid=$key";
    NetWorkHelper netWorkHelper = NetWorkHelper(url: urlCurrent);
    NetWorkHelper netWorkHelper2 = NetWorkHelper(url: urlForecast);
    dynamic data = await netWorkHelper.GetData();
    dynamic dataForecast = await netWorkHelper2.GetData();
    if (data == null || dataForecast == null) {
      print('Data error');
    }
    latitude = data["lat"];
    longitude = data["lon"];
    nameLocation = data["timezone"];
    currentTime = data["current"]["dt"];
    sunriseTime = data["current"]["sunrise"];
    sunsetTime = data["current"]["sunset"];
    temp = data["current"]["temp"];
    feelLikeTemp = data["current"]["feels_like"];
    pressure = data["current"]["pressure"];
    humidity = data["current"]["humidity"];
    visibility = data["current"]["visibility"];
    uvi = data["current"]["uvi"];
    windSpeed = data["current"]["wind_speed"];
    windDeg = data["current"]["wind_deg"];
    iconId = data["current"]["weather"];
    int test = iconId[0]["id"];
    //nameIcon = data["current"]["weather"]["main"];
    result.addAll([
      latitude, // 0
      longitude, // 1
      nameLocation, // 2
      currentTime, // 3
      sunriseTime, // 4
      sunsetTime, // 5
      temp, // 6
      feelLikeTemp, // 7
      pressure, // 8
      humidity, // 9
      visibility, //10
      uvi, // 11
      windSpeed, // 12
      windDeg, // 13
      test, // 14
    ]);
    //
    List<dynamic> tempForecast = [],
        feelLikeTempForecast = [],
        maxTempForecast = [],
        weatherInfo = [],
        pop = [];
    List<int> idIconForecast = [];
    int currentId;
    List<String>? dateForecast = [];
    String dtTxt = "";
    List<dynamic> allInfo = dataForecast["list"] as List;
    for (int i = 0; i < allInfo.length; i++) {
      tempForecast.add(allInfo[i]["main"]["temp"]);
      feelLikeTempForecast.add(allInfo[i]["main"]["feels_like"]);
      maxTempForecast.add(allInfo[i]["main"]["temp_max"]);
      weatherInfo.add(allInfo[i]["weather"][0]);
      currentId = weatherInfo[i]["id"];
      idIconForecast.add(currentId);
      dtTxt = allInfo[i]["dt_txt"];
      dateForecast.add(dtTxt);
      pop.add(allInfo[i]["pop"]);
    }
    List<dynamic> tempForecasth = [],
        feelLikeTempForecasth = [],
        weatherInfoh = [],
        poph = [];
    List<int> idIconForecasth = [];
    int currentIdh;
    List<int> dateForecasth = [];
    int dtTxth;
    List<dynamic> hourlyInfo = data["hourly"] as List;
    for (int i = 0; i < hourlyInfo.length; i++) {
      tempForecasth.add(hourlyInfo[i]["temp"]);
      feelLikeTempForecasth.add(hourlyInfo[i]["feels_like"]);
      weatherInfoh.add(hourlyInfo[i]["weather"][0]);
      currentIdh = weatherInfoh[i]["id"];
      idIconForecasth.add(currentIdh);
      dtTxth = hourlyInfo[i]["dt"];
      dateForecasth.add(dtTxth);
      poph.add(hourlyInfo[i]["pop"]);
    }
    resultHourly.addAll([
      tempForecasth,
      feelLikeTempForecasth,
      idIconForecasth,
      dateForecasth,
      poph
    ]);
    resultForecast.addAll([
      tempForecast, // 0
      feelLikeTempForecast, // 1
      maxTempForecast, // 2
      dateForecast, // 3
      idIconForecast, // 4
      pop, // 5
    ]);
    return [result, resultForecast, resultHourly];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        //gradient: LinearGradient(colors: [Color(0xFFF3DBAB), Color(0xffffb013)], begin: Alignment.bottomCenter, end: Alignment.topCenter)
        image: DecorationImage(
          image: AssetImage("images/morning.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SizedBox.expand(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BlocBuilder<LocationCubit, locationState>(
                  builder: (context, locationState) {
                    if (locationState is LocationLoading) {
                      return SizedBox(
                          height: MediaQuery.of(context).size.width * 1.5,
                          child: Center(
                              child: CircularProgressIndicator(
                            color: Colors.white,
                          )));
                    }
                    if (locationState is LocationError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            duration: Duration(seconds: 2),
                            backgroundColor: Colors.redAccent.withOpacity(0.6),
                            content:
                                const Text("Error, unable to catch location.")),
                      );
                    }
                    if (locationState is LocationLoaded) {
                      double latitude = locationState.latitude;
                      double longitude = locationState.longitude;
                      List<dynamic> result = [];
                      List<dynamic> resultForecast = [];
                      List<dynamic> resultHourly = [];
                      getNewLocation(latitude, longitude)
                          .then((value) => _address = value);
                      return FutureBuilder(
                        future: GetData(
                            latitude1: latitude,
                            longitude1: longitude,
                            result: result,
                            resultForecast: resultForecast,
                            resultHourly: resultHourly),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return CurrentWeather(
                              result: result,
                              address: _address!,
                              resultForecast: resultForecast,
                              resultHourly: resultHourly,
                            );
                          } else {
                            return Container();
                          }
                        },
                      );
                    } else {
                      return Container(
                        child: Text("No good"),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
