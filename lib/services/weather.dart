import 'package:flutter/material.dart';
import 'package:weather_land/services/location.dart';
import 'package:weather_land/services/networks.dart';
import 'package:weather_land/constatns.dart';

final apiKey = myApiKey;

class WeatherData {
  dynamic condition;
  var dateTime;
  List<String> paths = [
    'images/sun.png',
    'images/Moon2.png',
    'images/rainyCloud.png',
    'images/lightningCloud.png',
    'images/snowCloud.png',
    'images/drizzle.png',
    'images/mist.png',
    'images/cloudWithMoon.png',
    'images/cloud.png'
  ];
  String getPaths({int? Condition, var datetime}) {
    condition = Condition;
    dateTime = datetime;

    if (condition == 800 && (dateTime.hour >= 18 || dateTime.hour <= 6))
      return paths[1];
    else if (condition == 800 && (dateTime.hour <= 18 && dateTime.hour >= 6))
      return paths[0];
    else if (condition! > 800 && (dateTime.hour <= 18 && dateTime.hour >= 6))
      return paths[8];
    else if (condition! > 800 && (dateTime.hour >= 18 || dateTime.hour <= 6))
      return paths[7];
    else if (condition! > 700)
      return paths[6];
    else if (condition! >= 600)
      return paths[4];
    else if (condition! >= 500)
      return paths[2];
    else if (condition! >= 300)
      return paths[5];
    else if (condition! >= 200)
      return paths[3];
    else
      return paths[8];
  }

  Color getBgColor(var dateTime) {
    if (dateTime.hour >= 18 || dateTime.hour <= 6)
      return Color(0xFF707070);
    else
      return Color(0xFFFFF1C7);
  }

  Future<dynamic> getCityWeatherData(String cityName) async {
    String url =
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric';
    Networks networks = new Networks(Uri.parse(url));
    var weatherData = await networks.getData();
    return weatherData;
  }

  Future<dynamic> getCurrentWeatherData() async {
    Location loc = Location();
    await loc.getCurrentLocation();
    var latitude = loc.latitude;
    var longitude = loc.longitude;

    Networks networks = new Networks(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric'));
    var weatherData = await networks.getData();
    return weatherData;
  }
}
