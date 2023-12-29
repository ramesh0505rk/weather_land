import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_land/screens/city_screen.dart';
import 'package:weather_land/services/weather.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});
  final locationWeather;

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  var temperature;
  var description;
  dynamic condition;
  var cityName;
  var timezone;

  Color? bgColor;
  String? imgPath;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = '0';
        bgColor = Colors.white70;
        imgPath = 'images/wrong.png';
        cityName = 'Oops something went wrong';
        return;
      }
      temperature = weatherData['main']['temp'];
      condition = weatherData['weather'][0]['id'];
      cityName = weatherData['name'];
      timezone = weatherData['timezone'];
      description = weatherData['weather'][0]['description'];

      var dateTime = DateTime.now().add(Duration(
          seconds: timezone - DateTime.now().timeZoneOffset.inSeconds));
      print(cityName);
      print(weatherData);
      print(dateTime.hour);
      WeatherData weatherdata = WeatherData();
      bgColor = weatherdata.getBgColor(dateTime);
      imgPath =
          WeatherData().getPaths(Condition: condition, datetime: dateTime);
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: bgColor,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
      ),
      constraints: BoxConstraints.expand(),
      child: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                  child: GestureDetector(
                    onTap: () async {
                      updateUI(await WeatherData().getCurrentWeatherData());
                    },
                    child: SvgPicture.asset(
                      'icons/navigation.svg',
                      height: 30,
                      width: 30,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 10, 0),
                  child: GestureDetector(
                    onTap: () async {
                      var cityName = await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CityScreen();
                      }));
                      if (cityName != null) {
                        var weatherData =
                            await WeatherData().getCityWeatherData(cityName);
                        updateUI(weatherData);
                      }
                    },
                    child: SvgPicture.asset(
                      'icons/location.svg',
                      height: 30,
                      width: 30,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 90,
            ),
            DefaultTextStyle(
              style: TextStyle(
                fontFamily: 'Pacifico',
                color: Colors.black54,
                fontSize: 30,
              ),
              child: Text(
                cityName,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Image(
              image: AssetImage(imgPath!),
              width: 300,
              height: 200,
            ),
            SizedBox(
              height: 30,
            ),
            DefaultTextStyle(
              style: TextStyle(
                color: Colors.black54,
                fontFamily: 'Pacifico',
                fontSize: 60,
              ),
              child: Text(
                temperature.toString() + '°',
              ),
            ),
            SizedBox(
              height: 30,
            ),
            DefaultTextStyle(
              style: TextStyle(
                fontFamily: 'Pacifico',
                color: Colors.black54,
                fontSize: 30,
              ),
              child: Text(
                description,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
