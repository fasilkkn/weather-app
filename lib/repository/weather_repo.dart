


import 'package:weather_app/data/network/base_api_service.dart';
import 'package:weather_app/data/network/network_api_service.dart';
import 'package:weather_app/model/eather_model.dart';
import 'package:weather_app/res/app_urls.dart';

class WeatherRepository{

   BaseApiServices apiServices = NetworkApiServices();


   Future<Weather> getWeather(String cityName)async {
     try{
       dynamic response = await apiServices.getAPiResponse('${AppUrl.baseUrl}?q=$cityName&appid=${AppUrl.apiKey}&units=metric');
       return response;
     }catch(e){
       throw e;
     }
   }



}