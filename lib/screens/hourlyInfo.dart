import 'package:flutter/material.dart';

class HourlyInfo extends StatelessWidget {
  HourlyInfo(
      {required this.resultForecast,
      required this.currentIcons,
      required this.iconPath,
      required this.temp,
      required this.date,
      required this.pop, required this.resultHourly});

  final Map<int, String> currentIcons;
  final List<dynamic> resultForecast;
  final List<dynamic> resultHourly;
  final String iconPath;
  final dynamic temp;
  final int date;
  final dynamic pop;
  String fontFamily = 'Poppins';

  String substringDate(int date) {
    String stringTime = '';
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(date * 1000);
    stringTime = dateTime.toString();
    stringTime = stringTime.substring(stringTime.indexOf(' ') + 1, stringTime.length);
    stringTime = stringTime.substring(0, 5);
    return stringTime;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width / 1.1) / 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
              height: 60,
              width: 60,
              child: Image(image: AssetImage(iconPath), fit: BoxFit.contain)),
          Container(
            child: Text(
              '${temp.round()}°С',
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: 20,
              ),
            ),
          ),
          Container(
            child: Text(
              substringDate(date),
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: 20,
              ),
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 20,
                    height: 20,
                    child: Image(
                      image: AssetImage('images/glassicons/Drop.png'),
                      fit: BoxFit.contain,
                    )),
                Text(
                  '${(pop * 100).round()}%',
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 20,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
