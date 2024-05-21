import 'package:flutter/material.dart';
import 'package:weather_app/model/weather_model.dart';

class BackgroundWidget extends StatelessWidget {
  final WeatherData? weatherData;

  BackgroundWidget({required this.weatherData});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          _getBackgroundImage(),
          fit: BoxFit.cover,
          opacity: const AlwaysStoppedAnimation<double>(0.7),
        ),
      ],
    );
  }

  String _getBackgroundImage() {
    switch (weatherData!.main) {
      case 'Clouds':
        return 'assets/images/cloud.png';
      case 'Snow':
        return 'assets/images/winter.png';
      case 'Sunny':
        return 'assets/images/summer.png';
      case 'Rain':
        return 'assets/images/rain.png';
      default:
        return 'assets/images/summer.png';
    }
  }
}
