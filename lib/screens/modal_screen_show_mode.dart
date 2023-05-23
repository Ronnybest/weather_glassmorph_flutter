import 'package:flutter/material.dart';

class ShowMoreInfo extends StatelessWidget {
  ShowMoreInfo(
      {required this.pressure,
      required this.humidity,
      required this.uvi,
      required this.visibility,
      required this.windSpeed,
      required this.windDirection,
      required this.buildBlur});

  final dynamic pressure;
  final dynamic humidity;
  final dynamic uvi;
  final dynamic visibility;
  final dynamic windSpeed;
  final dynamic windDirection;
  final Function buildBlur;
  String fontFamily = 'Poppins';
  double fontSize = 24;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              SizedBox(
                height: 14,
              ),
              Container(
                width: 70,
                height: 7,
                decoration: BoxDecoration(
                    color: Color(0x5F222222),
                    borderRadius: BorderRadius.circular(40)),
              ),
              SizedBox(
                height: 14,
              ),
              // Text(
              //   'Current',
              //   style: TextStyle(fontFamily: fontFamily, fontSize: fontSize),
              // ),
            ],
          ),
          SizedBox(
            height: 14,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Pressure:',
                style: TextStyle(fontFamily: fontFamily, fontSize: fontSize, color: Color(0xFF222222)),
              ),
              Text(
                '$pressure hPa',
                style: TextStyle(fontFamily: fontFamily, fontSize: fontSize, color: Color(0xFF222222)),
              ),
            ],
          ),
          SizedBox(
            height: 14,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Humidity:',
                style: TextStyle(fontFamily: fontFamily, fontSize: fontSize, color: Color(0xFF222222)),
              ),
              Text(
                '$humidity%',
                style: TextStyle(fontFamily: fontFamily, fontSize: fontSize, color: Color(0xFF222222)),
              ),
            ],
          ),
          SizedBox(
            height: 14,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'UV index:',
                style: TextStyle(fontFamily: fontFamily, fontSize: fontSize, color: Color(0xFF222222)),
              ),
              Text(
                '$uvi',
                style: TextStyle(fontFamily: fontFamily, fontSize: fontSize, color: Color(0xFF222222)),
              ),
            ],
          ),
          SizedBox(
            height: 14,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Visibility:',
                style: TextStyle(fontFamily: fontFamily, fontSize: fontSize, color: Color(0xFF222222)),
              ),
              Text(
                '$visibility m',
                style: TextStyle(fontFamily: fontFamily, fontSize: fontSize, color: Color(0xFF222222)),
              ),
            ],
          ),
          SizedBox(
            height: 14,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Wind speed:',
                style: TextStyle(fontFamily: fontFamily, fontSize: fontSize, color: Color(0xFF222222)),
              ),
              Text(
                '${windSpeed.toStringAsFixed(1)} m/sec',
                style: TextStyle(fontFamily: fontFamily, fontSize: fontSize, color: Color(0xFF222222)),
              ),
            ],
          ),
          SizedBox(
            height: 14,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Wind direction:',
                style: TextStyle(fontFamily: fontFamily, fontSize: fontSize, color: Color(0xFF222222)),
              ),
              Text(
                '${checkPartOfWorld(windDirection)}',
                style: TextStyle(fontFamily: fontFamily, fontSize: fontSize, color: Color(0xFF222222)),
              ),
            ],
          ),
          SizedBox(
            height: 14,
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                children: [
                  Text(
                    'Designed by Jobes Joestar',
                    style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 12,
                        color: Color(0x8E222222)),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Made by Zeppon',
                    style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 12,
                        color: Color(0x8E222222)),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'From us with ♡',
                    style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 12,
                        color: Color(0x8E222222)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String checkPartOfWorld(dynamic degree) {
    if (degree == 0) {
      return 'N';
    } else if (degree == 90) {
      return 'E';
    } else if (degree == 180) {
      return 'S';
    } else if (degree == 270) {
      return 'W';
    } else if (degree > 0 && degree < 90) {
      return 'NE';
    } else if (degree > 90 && degree < 180) {
      return 'SE';
    } else if (degree > 180 && degree < 270) {
      return 'SW';
    } else if (degree > 180 && degree <= 359) {
      return 'NW';
    } else {
      return 'N/D';
    }
  }
}
