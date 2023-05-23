import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_glassmorph/screens/main_screen.dart';

import 'bloc/location_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocationCubit>(
            create: (context) => LocationCubit()..GetLocation()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: const Color(0xFF371B58),
            colorScheme: const ColorScheme.light().copyWith(
              primary: const Color(0xFF4C3575),
              secondary: const Color(0xFF5B4B8A),
              inversePrimary: const Color(0xFF7858A6),
            )),
        home: mainInfo(),
      ),
    );
  }
}
