import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class CardWidget extends StatelessWidget {
  const CardWidget(
      {required this.width,
      required this.height,
      required this.label,
      required this.color,
      required this.borderRadius,
      required this.textColor,
      required this.fontSize,
      required this.fontWeight,
      required this.paddings,
      required this.date,
      required this.fontFamily,
      required this.feelsLike,
      required this.currentIcons,
      required this.resultForecast,
      required this.iconPath, required this.blurBuilder});

  //final dynamic Function() onPressed;
  final String label;
  final Color color;
  final double borderRadius;
  final double width;
  final double height;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final String date;
  final List<double> paddings;
  final String fontFamily;
  final String feelsLike;
  final Map currentIcons;
  final List<dynamic> resultForecast;
  final String iconPath;
  final Function blurBuilder;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: blurBuilder(
        child: Container(
          // padding: EdgeInsets.fromLTRB(
          //     paddings[0], paddings[1], paddings[2], paddings[3]),
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(borderRadius),
            border: GradientBoxBorder(
                gradient: LinearGradient(
                    colors: [Color(0x2AFFFFFF), Color(0x3FFFFFFF)])),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Column(
                  // temp and date
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '$date',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w300,
                        fontSize: 32,
                        color: textColor,
                      ),
                    ),
                    Text(
                      '$label',
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontWeight: fontWeight,
                        fontSize: fontSize,
                        color: textColor,
                      ),
                    ),
                    Text(
                      'Feels like $feelsLike°C',
                      style: TextStyle(
                        fontSize: 20,
                        color: textColor,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.only(right: 10, left: 10),
                    width: 145,
                    height: 145,
                    child: Image(
                        image: AssetImage(iconPath),
                        fit: BoxFit.contain),
                  ),
                  SizedBox(
                    width: 200,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
