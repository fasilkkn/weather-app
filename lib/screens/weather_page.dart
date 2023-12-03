import 'package:flutter/material.dart';
import 'package:weather_app/model/eather_model.dart';
import 'package:weather_app/services/weather_services.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final weatherServices = WeatherServices();
  Weather? _weather;

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


//weather animations
String getWeatherAnimation(String mainCondition) {
  switch (mainCondition.toLowerCase()) {
    case 'clouds':
    case 'mist' :
    case 'smoke':
    case 'haze' :
    case 'dust':
    case 'fog' :
    return 'assets/img/3d-mountain-landscape-against-sunset-sky-with-low-clouds_1048-12442.jpg';

    case 'rain':
    case 'drizzle' :
    case 'shower rain':
    return 'assets/img/rain.jpeg';

    case 'thunderstorm':
    return 'assets/img/thunderstorm.jpeg';

    case 'clear' :
    return 'assets/img/3d-hazy-mountain-range-against-sunset-sky_1048-10361.jpg';

    default :
    return 'assets/img/3d-hazy-mountain-range-against-sunset-sky_1048-10361.jpg';
  }}

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
        body: Stack(
          alignment: Alignment.center,
      children: [
        (_weather?.mainCondition == null)? const Center(child: CircularProgressIndicator()) :
        SizedBox(
          height: size.height,
          width: size.width,
          child: Image.asset(getWeatherAnimation('${_weather?.mainCondition}'), fit: BoxFit.fitHeight),
        ),

         Positioned(
          top: 60,
          left: 0,
          right: 0,
          child: Center(
            child: Column(
              children: [
                (_weather?.temp==null) ? const Text(''):
                Text('${_weather?.temp!.round()} °C' , style: const TextStyle(color: Colors.white, fontSize: 40),),
                (_weather?.mainCondition == null) ? Text(''):
                Text('${_weather?.mainCondition}', style: const TextStyle(color: Colors.white),),
                 Text(_weather?.cityName ?? '', style: const TextStyle(color: Colors.white),),
              ],
            ))),

            (_weather?.temp == null)? const SizedBox() :
        Positioned(
          bottom: 30,
          left: 10,
          right: 10,
          child: Column(
            children: [
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 const Text('Monday', style:  TextStyle(color: Colors.white),),

                 
                 Column(
                  children: [
                     Text('${_weather?.temp!.round()} °C' , style: const TextStyle(color: Colors.white),),
                    Text('${_weather?.mainCondition}', style: const TextStyle(color: Colors.white),),
                  ],
                 ),
               ],
             ),

             Divider(color: Colors.white54,),

             Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 const Text('Thuesday', style: const TextStyle(color: Colors.white),),

                 Column(
                  children: [
                     Text('${_weather?.temp!.round()} °C' , style: const TextStyle(color: Colors.white),),
                    Text('${_weather?.mainCondition}', style: const TextStyle(color: Colors.white),),
                  ],
                 ),
               ],
             ),

             const Divider(color: Colors.white54,),

             Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 const Text('Wednesday', style: TextStyle(color: Colors.white),),

                 Column(
                  children: [
                     Text('${_weather?.temp!.round()} °C' , style: const TextStyle(color: Colors.white),),
                    Text('${_weather?.mainCondition}', style: const TextStyle(color: Colors.white),),
                  ],
                 ),
               ],
             ),
              
            ],
          ),
        ),
      ],
    )
        );
  }
}
