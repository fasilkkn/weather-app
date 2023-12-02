import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart'as http;
import 'package:weather_app/model/eather_model.dart';

class WeatherServices {

  
  static var baseUrl    =   'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherServices(this.apiKey);

  Future<Weather>getWeather (String cityName) async{
   final response = await http.get(Uri.parse('$baseUrl?q=$cityName&appid=$apiKey&units=metric')); 

   if(response.statusCode == 200) {
    return Weather.fromJson(jsonDecode(response.body));
   }else {
    throw Exception('failed to load weather data');
   }
  }


  Future<String> getCurrentCity() async{
LocationPermission permission = await Geolocator.checkPermission();
if(permission == LocationPermission.denied){
  permission = await Geolocator.requestPermission();

}

//fetch the current location
Position position = await Geolocator.getCurrentPosition(
  desiredAccuracy: LocationAccuracy.high
);

//convert the location into a list of placemark object
List<Placemark>placemarks = 
  await placemarkFromCoordinates(position.latitude, position.longitude);


  //exract the city name from the first placemark
  String? city = placemarks[0].locality;
  return city ?? '';
  }
}