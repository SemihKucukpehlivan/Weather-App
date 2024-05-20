import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/model/weather_model.dart';

class WeatherAppService {
  static const apiKey = 'd9437e8d1dadaead1037169c9cb8ca2f';
  static const baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  Future<WeatherAppModel> fetchWeather(String city) async {
    final response = await http
        .get(Uri.parse('$baseUrl?q=$city&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      return WeatherAppModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load weather");
    }
  }
}
