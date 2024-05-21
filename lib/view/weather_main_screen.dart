import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/service/weather_service.dart';
import 'package:weather_app/view/constants/text_style_const.dart';
import 'package:weather_app/view/widgets/background.dart';
import 'package:weather_app/view/widgets/blur_card.dart';
import 'package:weather_app/view/widgets/weather_icon.dart';

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
                        Text(city!, style: TextStyleConst.cityLabelTextStyle),
                        Center(
                          child: Column(
                            children: [
                              WeatherIconWidget(
                                iconUrl: '${weatherData!.icon}',
                              ),
                              Text(
                                ' ${weatherData.temperature.truncate()}°',
                                style: TextStyleConst.temperatureLabelTextStyle,
                              ),
                              Text(
                                  capitalizeFirstLetters(
                                      weatherData.description),
                                  style:
                                      TextStyleConst.descriptionLabelTextStyle),
                              const SizedBox(height: 40),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  BlurCard(
                                      content: Text(
                                          'Nem\n ${weatherData.humidity}%'),
                                      image: "wing.png"),
                                  BlurCard(
                                    content: Text(
                                        'Rüzgar Hızı\n  ${weatherData.windSpeed} m/s'),
                                    image: "nem.png",
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
}
