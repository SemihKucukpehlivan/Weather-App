import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/model/weather_forecast_model.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:provider/provider.dart';

class WeatherAppService {
  static const apiKey = 'd9437e8d1dadaead1037169c9cb8ca2f';
  static const baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
  static const forecastBaseUrl =
      'https://api.openweathermap.org/data/2.5/forecast';

  Future<void> fetchWeather(BuildContext context, String city) async {
    final response = await http.get(
      Uri.parse('$baseUrl?q=$city&appid=$apiKey&units=metric'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final weatherData = WeatherData.fromJson(data);
      Provider.of<WeatherProvider>(context, listen: false)
          .setWeatherData(weatherData);
    } else {
      throw Exception('Bir hata oluştu.');
    }
  }

  Future<List<WeatherForecast>> fetchWeatherForecast(String city) async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> weatherList = data['list'];

      // 3 farklı gün için birer veri seçiyoruz
      Map<String, WeatherForecast> dailyWeather = {};
      for (var weatherJson in weatherList) {
        WeatherForecast weather = WeatherForecast.fromJson(weatherJson);
        String dateKey = weather.date.toIso8601String().split('T')[0];
        if (!dailyWeather.containsKey(dateKey)) {
          dailyWeather[dateKey] = weather;
        }
        if (dailyWeather.length == 3) {
          break;
        }
      }

      return dailyWeather.values.toList();
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
