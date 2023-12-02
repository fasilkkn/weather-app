

 import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/data/response/api_response.dart';
import 'package:weather_app/model/eather_model.dart';
import 'package:weather_app/repository/weather_repo.dart';


class WeatherViewModel with ChangeNotifier{

 final myRepository = WeatherRepository();

 ApiResponse<Weather>weather =ApiResponse.loading();

 weatherGet(ApiResponse<Weather> response){
  weather = response;
  notifyListeners();
 }
 
 Future<dynamic>getWeather()async {
  final String city = await getCurrentCity();
  weatherGet(ApiResponse.loading());
   
  myRepository.getWeather(city).then((value){
   weatherGet(ApiResponse.completed(value));
  }).onError((error, stackTrace){
   weatherGet(ApiResponse.error(error.toString()));
  });
 }



 Future<String>getCurrentCity() async{

//get permission from user
LocationPermission permission = await Geolocator.checkPermission();
permission = await Geolocator.requestPermission();

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