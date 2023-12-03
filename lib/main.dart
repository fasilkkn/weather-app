import 'package:flutter/material.dart';
import 'package:weather_app/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/services/weather_services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [

        ChangeNotifierProvider(create: (_)=>WeatherServices()),


    ],child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
      fontFamily: 'Poppins'
      ),
home: const Splash(),
    ),);
  }
}
