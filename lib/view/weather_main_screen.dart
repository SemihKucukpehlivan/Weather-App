import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/service/weather_service.dart';
import 'package:weather_app/view/widgets/background.dart';

class WeatherMainScreen extends StatefulWidget {
  const WeatherMainScreen({super.key});

  @override
  State<WeatherMainScreen> createState() => _WeatherMainScreenState();
}

class _WeatherMainScreenState extends State<WeatherMainScreen> {
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Consumer<WeatherProvider>(
          builder: (context, provider, _) {
            if (provider.weatherData == null) {
              return const Center(child: CircularProgressIndicator());
            } else {
              final weatherData = provider.weatherData;
              return Stack(
                children: [
                  BackgroundWidget(weatherData: weatherData),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          city!,
                          style: const TextStyle(
                              fontSize: 38, color: Colors.white),
                        ),
                        Center(
                          child: Column(
                            children: [
                              Image.network(
                                'https://openweathermap.org/img/wn/${weatherData!.icon}@2x.png',
                                width: MediaQuery.of(context).size.width * 0.65,
                                fit: BoxFit.cover,
                              ),
                              Text(
                                ' ${weatherData.temperature.truncate()}°',
                                style: const TextStyle(
                                    fontSize: 90,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                capitalizeFirstLetters(weatherData.description),
                                style: const TextStyle(
                                    fontSize: 22, color: Colors.white),
                              ),
                              const SizedBox(height: 40),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  _buildBlurCard(
                                      content: Text(
                                          'Nem\n ${weatherData.humidity}%'),
                                      image: "assets/images/wing.png"),
                                  _buildBlurCard(
                                    content: Text(
                                        'Rüzgar Hızı\n  ${weatherData.windSpeed} m/s'),
                                    image: "assets/images/nem.png",
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  String capitalizeFirstLetters(String str) {
    if (str.isEmpty) return str;
    return str.split(' ').map((word) {
      if (word.isNotEmpty) {
        return word[0].toUpperCase() + word.substring(1);
      } else {
        return '';
      }
    }).join(' ');
  }

  Widget _buildBlurCard({required Widget content, required String image}) {
    return Container(
      width: 125,
      height: 175,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.white.withOpacity(0.7),
      ),
      margin: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            image,
            width: 75,
            height: 75,
          ),
          const SizedBox(height: 10),
          content,
        ],
      ),
    );
  }
}
