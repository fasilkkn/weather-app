import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/data/response/status.dart';
import 'package:weather_app/model/eather_model.dart';
import 'package:weather_app/res/app_urls.dart';
import 'package:weather_app/services/weather_services.dart';
import 'package:weather_app/view_model/weather_view_model.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final weatherServices = WeatherServices(AppUrl.apiKey);
  Weather? _weather;

//api key
  WeatherViewModel homeViewModel = WeatherViewModel();

  fetchWeather() async {
    String cityName = await weatherServices.getCurrentCity();

    try {
      final weather = await weatherServices.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    fetchWeather();
    super.initState();
  }

//fetch weather

//weather animations
String getWeatherAnimation(String mainCondition) {
  if(mainCondition == null) return 'assets/lottie/Animation - 1701493770281.json';
  switch (mainCondition.toLowerCase()) {
    case 'clouds':
    case 'mist' :
    case 'smoke':
    case 'haze' :
    case 'dust':
    case 'fog' :
    return 'assets/lottie/clouds.json';

    case 'rain':
    case 'drizzle' :
    case 'shower rain':
    return 'assets/lottie/rain.json';

    case 'thunderstorm':
    return 'assets/lottie/thunderstorm.json';

    case 'clear' :
    return 'assets/lottie/sunny.json';

    default :
    return 'assets/lottie/sunny.json';
  }}

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blue,
        body: Stack(
      children: [
        SizedBox(
          height: size.height,
          width: size.width,
          child: Lottie.asset(getWeatherAnimation('${_weather?.mainCondition}'), fit: BoxFit.contain),
        ),
        Positioned(
          right: 0,
          left: 0,
          bottom: 60,
          child: Column(
            children: [
              Text(_weather?.cityName ?? 'loading city name', style: const TextStyle(color: Colors.white),),
              Text('${_weather?.temp!.round()}°C' , style: const TextStyle(color: Colors.white),),
              Text('${_weather?.mainCondition}', style: const TextStyle(color: Colors.white),),
            ],
          ),
        ),
      ],
    )

        // ChangeNotifierProvider(
        //   create: (BuildContext context) =>homeViewModel ,
        //   child: Consumer<WeatherViewModel>(
        //     builder: (context,value,_) {
        //       switch(value.weather.status){

        //         case Status.Loading:
        //           return const Center(child:  CircularProgressIndicator());

        //           case Status.Error:
        //           return  Center(child: Text(value.weather.message.toString()));

        //           case Status.Completed :
        //           return Column(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: [
        //                 Text(value.weather.data!.cityName.toString()),
        //                 Text(value.weather.data!.cityName.toString()),
        //             ],
        //             );

        //         case null:
        //           // TODO: Handle this case.
        //     }
        //     return Container();
        //     }
        //   ),
        // ),
        );
  }
}
