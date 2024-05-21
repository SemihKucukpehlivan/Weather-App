import 'package:flutter/material.dart';
import 'package:weather_app/model/weather_model.dart';

class BackgroundWidget extends StatelessWidget {
  final WeatherData? weatherData;

  BackgroundWidget({required this.weatherData});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      _getBackgroundImage(),
      fit: BoxFit.cover,
    );
  }

  String _getBackgroundImage() {
    switch (weatherData!.main) {
      case 'Clouds':
        return 'assets/images/cloud.png';
      case 'Clear':
        return 'assets/images/nem.png';
      // Diğer durumları buraya ekleyin
      default:
        return 'assets/images/sunny.png';
    }
  }
}
