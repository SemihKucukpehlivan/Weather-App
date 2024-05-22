import 'package:flutter/material.dart';
import 'package:weather_app/model/weather_forecast_model.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/service/weather_service.dart';

class WeatherProvider with ChangeNotifier {
  WeatherData? _weatherData;
  WeatherForecast? _weatherForecast;
  String? _city;
  List<WeatherForecast> _weatherList = [];

  WeatherData? get weatherData => _weatherData;
  WeatherForecast? get weatherForecast => _weatherForecast;
  String? get city => _city;
  List<WeatherForecast> get weatherList => _weatherList;

  void setWeatherData(WeatherData weatherData) {
    _weatherData = weatherData;
    _weatherForecast = weatherForecast;
    notifyListeners();
  }

  void setCity(String city) {
    _city = city;
    notifyListeners();
  }

  Future<void> fetchWeather() async {
    try {
      _weatherList = await WeatherAppService().fetchWeatherForecast(_city!);
    } catch (e) {
      print(e);
    } finally {
      notifyListeners();
    }
    notifyListeners();
  }
}
