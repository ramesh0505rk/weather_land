import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_land/screens/location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_land/services/weather.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});
  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

double? latitude, longitude;

class _LoadingScreenState extends State<LoadingScreen> {
  Future<void> getLocation() async {
    dynamic weatherData = await WeatherData().getCurrentWeatherData();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        locationWeather: weatherData,
      );
    }));
  }

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    // Build method should not call getData here
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SpinKitChasingDots(
            color: Colors.black54,
            size: 60,
          ),
        ),
      ),
    );
  }
}
