import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weather_glassmorph/screens/hourlyInfo.dart';
import 'package:weather_glassmorph/screens/modal_screen_show_mode.dart';
import 'cardsWidget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CurrentWeather extends StatelessWidget {
  CurrentWeather(
      {required this.result,
      required this.address,
      required this.resultForecast,
      required this.resultHourly});

  final _controller = PageController();
  final List<String> address;
  final List<dynamic> result;
  final List<dynamic> resultForecast;
  final List<dynamic> resultHourly;
  double fontSize = 64;
  Map<int, String> dayIcons = {
    800: "images/glassicons/01.sun-light.png",
    801: "images/glassicons/05.partial-cloudy-light.png",
    803: "images/glassicons/07.mostly-cloud-light.png",
    802: "images/glassicons/15.cloud-light.png",
    804: "images/glassicons/11.mostly-cloudy-light.png",
    210: "images/glassicons/12.thunder-light.png",
    201: "images/glassicons/13.thunderstorm-light.png",
    601: "images/glassicons/14.heavy-snowfall-light.png",
    600: "images/glassicons/22.snow-light.png",
    502: "images/glassicons/18.heavy-rain-light.png",
    500: "images/glassicons/20.rain-light.png",
    0: "images/glassicons/not-found.png",
  };

  //
  Map<int, String> nightIcons = {
    800: "images/glassicons/09.half-moon-light.png",
    801: "images/glassicons/10.cloudy-night-light.png",
    803: "images/glassicons/11.mostly-cloudy-light.png",
    802: "images/glassicons/16.cloudy-night-light.png",
    804: "images/glassicons/15.cloud-light.png",
    210: "images/glassicons/12.thunder-light.png",
    201: "images/glassicons/13.thunderstorm-light.png",
    601: "images/glassicons/14.heavy-snowfall-light.png",
    600: "images/glassicons/22.snow-light.png",
    502: "images/glassicons/18.heavy-rain-light.png",
    500: "images/glassicons/20.rain-light.png",
    0: "images/glassicons/not-found.png",
  };

  Map<int, String> currentIcons = {};

  List<String> dateAndTime = [];
  late List<String> dateAll = resultForecast[3] as List<String>;

  void getDate() {
    for (int i = 0; i < dateAll.length; i++) {
      dateAndTime.add(dateAll[i].substring(5, dateAll[i].indexOf(' ')));
    }
  }

  void setActiveIcons() {
    DateTime now = DateTime.now();
    //now = now.toUtc();
    if (now.hour >= 21) {
      currentIcons = nightIcons;
    } else if (now.hour >= 5) {
      currentIcons = dayIcons;
    }
  }

  Map<int, String> SetIconHourly(date) {
    String stringTime = '';
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(date * 1000);
    stringTime = dateTime.toString();
    stringTime =
        stringTime.substring(stringTime.indexOf(' ') + 1, stringTime.length);
    stringTime = stringTime.substring(0, 2);
    if (int.parse(stringTime) >= 21 || int.parse(stringTime) <= 5) {
      return nightIcons;
    } else {
      return dayIcons;
    }
  }

  @override
  Widget build(BuildContext context) {
    getDate();
    setActiveIcons();
    return Column(
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        buildBlur(
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width / 1.1,
            height: 100,
            decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
              //color: Color(0x41FFFFFF),
              gradient: LinearGradient(
                  colors: [Color(0x42FFFFFF), Color(0x6EFFFFFF)]),
              borderRadius: BorderRadius.all(Radius.circular(20)),
              border: GradientBoxBorder(
                  gradient: LinearGradient(
                      colors: [Color(0x2AFFFFFF), Color(0x3FFFFFFF)])),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  address[1].toUpperCase(), // country
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  address[0].toUpperCase(), // city
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    color: Color(0xFF222222),
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          height: 200,
          width: MediaQuery.of(context).size.width,
          child: PageView(
            controller: _controller,
            children: [
              CardWidget(
                blurBuilder: buildBlur,
                  iconPath: currentIcons[result[14]] == null
                      ? currentIcons[0].toString()
                      : currentIcons[result[14]].toString(),
                  resultForecast: resultForecast,
                  feelsLike: '${result[7].round().toString()}',
                  height: 200,
                  color: Color(0x41FFFFFF),
                  borderRadius: 20,
                  width: MediaQuery.of(context).size.width / 1.1,
                  label: "${result[6].round().toString()}°С",
                  fontSize: fontSize,
                  fontWeight: FontWeight.w700,
                  textColor: Color(0xFF020202),
                  paddings: [15, 0, 10, 0],
                  date: 'Current',
                  fontFamily: 'Rubik',
                  currentIcons: currentIcons,
                ),
              CardWidget(
                blurBuilder: buildBlur,
                  iconPath: dayIcons[resultForecast[4][7]] == null
                      ? dayIcons[0].toString()
                      : dayIcons[resultForecast[4][7]].toString(),
                  resultForecast: resultForecast,
                  feelsLike: '${resultForecast[1][7].round().toString()}',
                  height: 200,
                  color: Color(0x41FFFFFF),
                  borderRadius: 20,
                  width: MediaQuery.of(context).size.width / 1.1,
                  label: "${resultForecast[2][7].round().toString()}°С",
                  fontSize: fontSize,
                  fontWeight: FontWeight.w700,
                  textColor: Color(0xFF020202),
                  paddings: [15, 0, 10, 0],
                  date: dateAndTime[7],
                  fontFamily: 'Rubik',
                  currentIcons: currentIcons,
                ),
                CardWidget(
                  blurBuilder: buildBlur,
                  iconPath: dayIcons[resultForecast[4][14]] == null
                      ? dayIcons[0].toString()
                      : dayIcons[resultForecast[4][14]].toString(),
                  resultForecast: resultForecast,
                  feelsLike: '${resultForecast[1][14].round().toString()}',
                  height: 200,
                  color: Color(0x41FFFFFF),
                  borderRadius: 20,
                  width: MediaQuery.of(context).size.width / 1.1,
                  label: "${resultForecast[2][14].round().toString()}°С",
                  fontSize: fontSize,
                  fontWeight: FontWeight.w700,
                  textColor: Color(0xFF020202),
                  paddings: [15, 0, 10, 0],
                  date: dateAndTime[14],
                  fontFamily: 'Rubik',
                  currentIcons: currentIcons,
                ),
                  CardWidget(
                    blurBuilder: buildBlur,
                  iconPath: dayIcons[resultForecast[4][21]] == null
                      ? dayIcons[0].toString()
                      : dayIcons[resultForecast[4][21]].toString(),
                  resultForecast: resultForecast,
                  feelsLike: '${resultForecast[1][21].round().toString()}',
                  height: 200,
                  color: Color(0x41FFFFFF),
                  borderRadius: 20,
                  width: MediaQuery.of(context).size.width / 1.1,
                  label: "${resultForecast[2][21].round().toString()}°С",
                  fontSize: fontSize,
                  fontWeight: FontWeight.w700,
                  textColor: Color(0xFF020202),
                  paddings: [15, 0, 10, 0],
                  date: dateAndTime[21],
                  fontFamily: 'Rubik',
                  currentIcons: currentIcons,
                ),
                  CardWidget(
                    blurBuilder: buildBlur,
                  iconPath: dayIcons[resultForecast[4][28]] == null
                      ? dayIcons[0].toString()
                      : dayIcons[resultForecast[4][28]].toString(),
                  resultForecast: resultForecast,
                  feelsLike: '${resultForecast[1][28].round().toString()}',
                  date: dateAndTime[31],
                  height: 200,
                  color: const Color(0x41FFFFFF),
                  borderRadius: 20,
                  width: MediaQuery.of(context).size.width / 1.1,
                  //label: result[6].round().toString(),
                  label: "${resultForecast[2][28].round().toString()}°С",
                  fontSize: fontSize,
                  fontWeight: FontWeight.w700,
                  textColor: const Color(0xFF020202),
                  paddings: [15, 0, 10, 0],
                  fontFamily: 'Rubik',
                  currentIcons: currentIcons,
                ),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        SmoothPageIndicator(
          controller: _controller,
          count: 5,
          effect: const SwapEffect(
            dotColor: Color(0x6EFFFFFF),
            activeDotColor: Color(0xEDFFFFFF),
            dotHeight: 10,
            dotWidth: 10,
          ),
        ),
        const SizedBox(
          height: 45,
        ),
        buildBlur(
          child: Container(
            height: 250,
            width: MediaQuery.of(context).size.width / 1.1,
            decoration: BoxDecoration(
              color: const Color(0x41FFFFFF),
              borderRadius: BorderRadius.circular(20),
            ),

            // tempForecasth,
            // feelLikeTempForecasth,
            // idIconForecasth,
            // dateForecasth,
            // poph
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                HourlyInfo(
                  resultHourly: resultHourly,
                  resultForecast: resultForecast,
                  currentIcons: currentIcons,
                  iconPath: SetIconHourly(
                              resultHourly[3][0])[resultHourly[2][0]] ==
                          null
                      ? SetIconHourly(resultHourly[3][0])[0].toString()
                      : SetIconHourly(resultHourly[3][0])[resultHourly[2][0]]
                          .toString(),
                  temp: resultHourly[0][0],
                  date: resultHourly[3][0],
                  pop: resultHourly[4][0],
                ),
                HourlyInfo(
                  resultHourly: resultHourly,
                  resultForecast: resultForecast,
                  currentIcons: currentIcons,
                  iconPath: SetIconHourly(
                              resultHourly[3][1])[resultHourly[2][1]] ==
                          null
                      ? SetIconHourly(resultHourly[3][1])[0].toString()
                      : SetIconHourly(resultHourly[3][1])[resultHourly[2][1]]
                          .toString(),
                  temp: resultHourly[0][1],
                  date: resultHourly[3][1],
                  pop: resultHourly[4][1],
                ),
                HourlyInfo(
                  resultHourly: resultHourly,
                  resultForecast: resultForecast,
                  currentIcons: currentIcons,
                  iconPath: SetIconHourly(
                              resultHourly[3][2])[resultHourly[2][2]] ==
                          null
                      ? SetIconHourly(resultHourly[3][2])[0].toString()
                      : SetIconHourly(resultHourly[3][2])[resultHourly[2][2]]
                          .toString(),
                  temp: resultHourly[0][2],
                  date: resultHourly[3][2],
                  pop: resultHourly[4][2],
                ),
                HourlyInfo(
                  resultHourly: resultHourly,
                  resultForecast: resultForecast,
                  currentIcons: currentIcons,
                  iconPath: SetIconHourly(
                              resultHourly[3][3])[resultHourly[2][3]] ==
                          null
                      ? SetIconHourly(resultHourly[3][3])[0].toString()
                      : SetIconHourly(resultHourly[3][3])[resultHourly[2][3]]
                          .toString(),
                  temp: resultHourly[0][3],
                  date: resultHourly[3][3],
                  pop: resultHourly[4][3],
                ),
                HourlyInfo(
                  resultHourly: resultHourly,
                  resultForecast: resultForecast,
                  currentIcons: currentIcons,
                  iconPath: SetIconHourly(
                              resultHourly[3][4])[resultHourly[2][4]] ==
                          null
                      ? SetIconHourly(resultHourly[3][4])[0].toString()
                      : SetIconHourly(resultHourly[3][4])[resultHourly[2][4]]
                          .toString(),
                  temp: resultHourly[0][4],
                  date: resultHourly[3][4],
                  pop: resultHourly[4][4],
                ),
                HourlyInfo(
                  resultHourly: resultHourly,
                  resultForecast: resultForecast,
                  currentIcons: currentIcons,
                  iconPath: SetIconHourly(
                              resultHourly[3][5])[resultHourly[2][5]] ==
                          null
                      ? SetIconHourly(resultHourly[3][5])[0].toString()
                      : SetIconHourly(resultHourly[3][5])[resultHourly[2][5]]
                          .toString(),
                  temp: resultHourly[0][5],
                  date: resultHourly[3][5],
                  pop: resultHourly[4][5],
                ),
                HourlyInfo(
                  resultHourly: resultHourly,
                  resultForecast: resultForecast,
                  currentIcons: currentIcons,
                  iconPath: SetIconHourly(
                              resultHourly[3][6])[resultHourly[2][6]] ==
                          null
                      ? SetIconHourly(resultHourly[3][6])[0].toString()
                      : SetIconHourly(resultHourly[3][6])[resultHourly[2][6]]
                          .toString(),
                  temp: resultHourly[0][6],
                  date: resultHourly[3][6],
                  pop: resultHourly[4][6],
                ),
                HourlyInfo(
                  resultHourly: resultHourly,
                  resultForecast: resultForecast,
                  currentIcons: currentIcons,
                  iconPath: SetIconHourly(
                              resultHourly[3][7])[resultHourly[2][7]] ==
                          null
                      ? SetIconHourly(resultHourly[3][7])[0].toString()
                      : SetIconHourly(resultHourly[3][7])[resultHourly[2][7]]
                          .toString(),
                  temp: resultHourly[0][7],
                  date: resultHourly[3][7],
                  pop: resultHourly[4][7],
                ),
                HourlyInfo(
                  resultHourly: resultHourly,
                  resultForecast: resultForecast,
                  currentIcons: currentIcons,
                  iconPath: SetIconHourly(
                              resultHourly[3][8])[resultHourly[2][8]] ==
                          null
                      ? SetIconHourly(resultHourly[3][8])[0].toString()
                      : SetIconHourly(resultHourly[3][8])[resultHourly[2][8]]
                          .toString(),
                  temp: resultHourly[0][8],
                  date: resultHourly[3][8],
                  pop: resultHourly[4][8],
                ),
                HourlyInfo(
                  resultHourly: resultHourly,
                  resultForecast: resultForecast,
                  currentIcons: currentIcons,
                  iconPath: SetIconHourly(
                              resultHourly[3][9])[resultHourly[2][9]] ==
                          null
                      ? SetIconHourly(resultHourly[3][9])[0].toString()
                      : SetIconHourly(resultHourly[3][9])[resultHourly[2][9]]
                          .toString(),
                  temp: resultHourly[0][9],
                  date: resultHourly[3][9],
                  pop: resultHourly[4][9],
                ),
                HourlyInfo(
                  resultHourly: resultHourly,
                  resultForecast: resultForecast,
                  currentIcons: currentIcons,
                  iconPath: SetIconHourly(
                              resultHourly[3][10])[resultHourly[2][10]] ==
                          null
                      ? SetIconHourly(resultHourly[3][10])[0].toString()
                      : SetIconHourly(resultHourly[3][10])[resultHourly[2][10]]
                          .toString(),
                  temp: resultHourly[0][10],
                  date: resultHourly[3][10],
                  pop: resultHourly[4][10],
                ),
                HourlyInfo(
                  resultHourly: resultHourly,
                  resultForecast: resultForecast,
                  currentIcons: currentIcons,
                  iconPath: SetIconHourly(
                              resultHourly[3][11])[resultHourly[2][11]] ==
                          null
                      ? SetIconHourly(resultHourly[3][11])[0].toString()
                      : SetIconHourly(resultHourly[3][11])[resultHourly[2][11]]
                          .toString(),
                  temp: resultHourly[0][11],
                  date: resultHourly[3][11],
                  pop: resultHourly[4][11],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          width: MediaQuery.of(context).size.width / 1.1,
          height: 100,
          child: GestureDetector(
            onPanUpdate: (details) {
              int sensivity = 7;
              if (details.delta.dy < -sensivity) {
                _showModalBottomSheet(context);
              }
            },
            child: buildBlur(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0x41FFFFFF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    'Swipe up to show more',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      color: Color(0xFF222222),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width / 1.1,
          height: 70,
          child: Center(
            child: RichText(
              text: TextSpan(
                  text: 'www.openweathermap.org',
                  style: TextStyle(
                    color: Color(0xFF222222),
                    fontFamily: 'Poppins',
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      _launchURL();
                    }),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _launchURL() async {
    final Uri url = Uri(scheme: 'https', host: 'www.openweathermap.org');
    if(!await launchUrl(url, mode: LaunchMode.externalApplication)){
      throw 'Could not launch $url';
    }
  }

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      barrierColor: Colors.transparent,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      backgroundColor: Color(0xffa8e7f0),
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.5,
        maxChildSize: 0.9,
        minChildSize: 0.32,
        builder: (context, scrollController) => ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
            child: SingleChildScrollView(
              child: ShowMoreInfo(
                pressure: result[8],
                humidity: result[9],
                uvi: result[11],
                visibility: result[10],
                windDirection: result[13],
                windSpeed: result[12],
                buildBlur: buildBlur,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBlur({
    required Widget child,
    double sigmaX = 0,
    double sigmaY = 0,
  }) =>
      ClipRRect(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaY: sigmaY, sigmaX: sigmaX),
          child: child,
        ),
      );
}
