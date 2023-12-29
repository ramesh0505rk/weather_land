import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_land/constatns.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({super.key});

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String? searchedCity;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFF707070),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(2, 0, 0, 0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset(
                      'icons/backArrow.svg',
                      height: 40,
                      width: 40,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(12),
                child: TextField(
                  decoration: inputDecoration,
                  onChanged: (value) {
                    searchedCity = value;
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, searchedCity);
                },
                child: Text(
                  'Get Weather',
                  style: TextStyle(
                    fontFamily: 'Pacifico',
                    fontSize: 20,
                    color: Colors.white70,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.black54),
                  minimumSize: MaterialStatePropertyAll(
                    Size(200, 50),
                  ),
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Image(
                  image: AssetImage('images/search.png'),
                  height: 400,
                  width: 300,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
