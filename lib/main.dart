import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/view/weather_welcom_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WeatherProvider(),
      child: SafeArea(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: WeatherScreen(),
        ),
      ),
    );
  }
}
