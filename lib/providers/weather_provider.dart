import 'package:flutter/material.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/service/weather_service.dart';

class WeatherProvider with ChangeNotifier {
  WeatherAppModel? _weatherAppModel;
  bool _isLoading = false;

  WeatherAppModel? get weather => _weatherAppModel;
  bool get isLoading => _isLoading;

  Future<void> fetchWeather(String city) async {
    _isLoading = true;
    notifyListeners();
    try {
      _weatherAppModel = await WeatherAppService().fetchWeather(city);
    } catch (e) {
      _weatherAppModel = null;
    }

    _isLoading = false;
    notifyListeners();
  }
}
