import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:provider/provider.dart';

class WeatherAppService {
  static const apiKey = 'd9437e8d1dadaead1037169c9cb8ca2f';
  static const baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

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
}
