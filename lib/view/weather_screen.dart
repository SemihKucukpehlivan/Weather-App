import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/service/weather_service.dart';

class WeatherScreen extends StatelessWidget {
  WeatherScreen({Key? key}) : super(key: key);

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Provider.of<WeatherProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Enter city'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                WeatherAppService().fetchWeather(context, _controller.text);
              },
              child: Text("Get City"),
            ),
            SizedBox(height: 16),
            Consumer<WeatherProvider>(
              builder: (context, provider, _) {
                if (provider.weatherData == null) {
                  return CircularProgressIndicator();
                } else {
                  final weatherData = provider.weatherData;
                  return Column(
                    children: [
                      Text('Sıcaklık: ${weatherData!.temperature}°C'),
                      Text('Nem: ${weatherData.humidity}%'),
                      Text('Rüzgar Hızı: ${weatherData.windSpeed} m/s'),
                      Text('Açıklama: ${weatherData.description}'),
                    ],
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
