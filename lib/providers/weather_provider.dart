import 'package:flutter/material.dart';
import 'package:weather_app/model/weather_model.dart';

class WeatherProvider with ChangeNotifier {
  WeatherData? _weatherData;

  WeatherData? get weatherData => _weatherData;

  void setWeatherData(WeatherData weatherData) {
    _weatherData = weatherData;
    notifyListeners();
  }
}
