import 'package:flutter/material.dart';
import 'package:weather_app/model/weather_model.dart';

class WeatherProvider with ChangeNotifier {
  WeatherData? _weatherData;
  String? _city;

  WeatherData? get weatherData => _weatherData;
  String? get city => _city;

  void setWeatherData(WeatherData weatherData) {
    _weatherData = weatherData;
    notifyListeners();
  }

  void setCity(String city) {
    _city = city;
    notifyListeners();
  }
}
