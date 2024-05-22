import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/weather_provider.dart';

class WeatherSeeMoreScreen extends StatefulWidget {
  const WeatherSeeMoreScreen({super.key});

  @override
  State<WeatherSeeMoreScreen> createState() => _WeatherSeeMoreScreenState();
}

class _WeatherSeeMoreScreenState extends State<WeatherSeeMoreScreen> {
  @override
  void initState() {
    super.initState();
    // Verileri yüklemek için fetchWeather metodunu çağırıyoruz.
    Provider.of<WeatherProvider>(context, listen: false).fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('3-Day Weather Forecast'),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: weatherProvider.weatherList.length,
          itemBuilder: (context, index) {
            final weather = weatherProvider.weatherList[index];
            return ListTile(
              title: Text(weather.date.toIso8601String().split('T')[0]),
              subtitle:
                  Text('${weather.temperature}°C, ${weather.description}'),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          weatherProvider.fetchWeather();
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
