import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/weather_provider.dart';

class WeatherScreen extends StatelessWidget {
  WeatherScreen({super.key});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: InputDecoration(labelText: 'enter city'),
          ),
          ElevatedButton(
            onPressed: () {
              weatherProvider.fetchWeather(_controller.text);
            },
            child: Text("Get City"),
          ),
          if (weatherProvider.isLoading) const CircularProgressIndicator(),
          if (weatherProvider.weather != null)
            Column(
              children: [
                Text(weatherProvider.weather!.cityName),
                Text("${weatherProvider.weather!.temperature} C"),
                Text("${weatherProvider.weather!.description}")
              ],
            )
        ],
      ),
    );
  }
}
