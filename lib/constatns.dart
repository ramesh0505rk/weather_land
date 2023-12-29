import 'package:flutter/material.dart';

final myApiKey = '657eb539d0e4a73ebbc8d0087863fb04';

final inputDecoration = InputDecoration(
    icon: Icon(
      Icons.search,
      color: Colors.white70,
    ),
    filled: true,
    fillColor: Colors.white70,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(25),
      ),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(25),
      ),
      borderSide: BorderSide.none,
    ),
    hintText: "Enter a city name",
    hintStyle: TextStyle(
      fontFamily: 'Pacifico',
    ));
