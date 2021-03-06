import 'package:flutter/material.dart';
import 'location.dart';
import 'package:clima/services/networking.dart';
const apiKey='80e28fa7d1c55cb4d7fbd4ac2c86ece4';
const openWeatherMapURL='https://api.openweathermap.org/data/2.5/weather';
class WeatherModel {



  Future<dynamic> getCityWeather(String city) async
  {
    var url='$openWeatherMapURL?q=$city&appid=$apiKey';
    NetworkHelper helper=NetworkHelper(url: url);

    var weatherDate=await helper.getData();
    return weatherDate;

  }

  Future<dynamic> getLocationWeather() async
  {
    Location location=Location();

    //HERE AWAITED UNTIL WE GET THE LOCATION
    await location.getCurrentLocation();



    NetworkHelper helper=NetworkHelper(url: '$openWeatherMapURL?lat=${location.lat}&lon=${location.long}&appid=$apiKey');

    //HERE AGAIN UNTIL WE GET DATA OF THE REQUIRED LATITTUDE AND LONGITUDE WE CANNOT MOVE FORWARD

    var weather_data=await helper.getData();
    return weather_data;

  }



  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ๏ธ';
    } else if (condition < 700) {
      return 'โ๏ธ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return 'โ๏ธ';
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s ๐ฆ time';
    } else if (temp > 20) {
      return 'Time for shorts and ๐';
    } else if (temp < 10) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }
}
