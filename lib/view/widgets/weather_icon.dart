import 'package:flutter/material.dart';

class WeatherIconWidget extends StatelessWidget {
  final String iconUrl;
  final double iconWidth;

  const WeatherIconWidget(
      {super.key, required this.iconUrl, required this.iconWidth});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      'https://openweathermap.org/img/wn/${iconUrl}@2x.png',
      width: iconWidth,
      fit: BoxFit.contain,
    );
  }
}


