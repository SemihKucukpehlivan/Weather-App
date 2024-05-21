import 'package:flutter/material.dart';

class WeatherIconWidget extends StatelessWidget {
  final String iconUrl;

  const WeatherIconWidget({super.key, required this.iconUrl});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      'https://openweathermap.org/img/wn/${iconUrl}@2x.png',
      width: MediaQuery.of(context).size.width * 0.65,
      fit: BoxFit.cover,
    );
  }
}
