import 'package:flutter/material.dart';
import 'package:rain_drop/services/location.dart';
import 'package:rain_drop/services/networking.dart';

const apiKey='07b2621048afbc5c621905471591005d';
class WeatherModel {

   Future<dynamic> getCityWeather(String cityName)async{

     NetworkHelper networkHelper=NetworkHelper('https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric');
     var weatherData=await networkHelper.getData();

      double latitude= weatherData["coord"]["lat"]??0.0;
      double longitude=weatherData["coord"]["lon"]??0.0;

      NetworkHelper cityHelper=NetworkHelper('https://api.openweathermap.org/data/3.0/onecall?lat=$latitude&lon=$longitude&exclude=hourly,daily,minutely,alerts&appid=07b2621048afbc5c621905471591005d&units=metric');
      var cityData= await cityHelper.getData();

      return cityData;
   }
  Future<dynamic> getLocationWeather() async{
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/3.0/onecall?lat=${location.latitude}&lon=${location.longitude}&exclude=hourly,daily,minutely,alerts&appid=07b2621048afbc5c621905471591005d&units=metric');

    NetworkHelper city=NetworkHelper('http://api.openweathermap.org/geo/1.0/reverse?lat=${location.latitude}&lon=${location.longitude}&limit=1&appid=$apiKey');


    var weatherData = await networkHelper.getData();
    var  cityData=await city.getData();

    return weatherData;
  }
  Future<String> getLocation() async{
    Location location = Location();
    await location.getCurrentLocation();
    NetworkHelper city=NetworkHelper('http://api.openweathermap.org/geo/1.0/reverse?lat=${location.latitude}&lon=${location.longitude}&limit=1&appid=$apiKey');
    var  cityData=await city.getData();

    return cityData[0]['name'];
  }
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
