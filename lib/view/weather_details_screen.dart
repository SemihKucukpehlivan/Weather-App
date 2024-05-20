import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/service/weather_service.dart';

class WeatherDetailScreen extends StatefulWidget {
  @override
  _WeatherDetailScreenState createState() => _WeatherDetailScreenState();
}

class _WeatherDetailScreenState extends State<WeatherDetailScreen> {
  @override
  void initState() {
    super.initState();
    final weatherProvider =
        Provider.of<WeatherProvider>(context, listen: false);
    WeatherAppService().fetchWeather(context, weatherProvider.city!);
  }

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);
    final city = weatherProvider.city;

    return Scaffold(
      appBar: AppBar(title: const Text("Weather Details")),
      body: Consumer<WeatherProvider>(
        builder: (context, provider, _) {
          if (provider.weatherData == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            final weatherData = provider.weatherData;
            return Column(
              children: [
                Text('Şehir: ${city}'),
                Text('Sıcaklık: ${weatherData!.temperature}°C'),
                Text('Nem: ${weatherData.humidity}%'),
                Text('Rüzgar Hızı: ${weatherData.windSpeed} m/s'),
                Text('Açıklama: ${weatherData.description}'),
                Image.network(
                    'https://openweathermap.org/img/wn/${weatherData.icon}@2x.png'),
                    
              ],
            );
          }
        },
      ),
    );
  }
}
