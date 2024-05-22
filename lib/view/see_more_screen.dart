import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/view/constants/text_style_const.dart';
import 'package:weather_app/view/helper/string_helper.dart';
import 'package:weather_app/view/widgets/background.dart';
import 'package:weather_app/view/widgets/weather_icon.dart';

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
    Future.microtask(() =>
        Provider.of<WeatherProvider>(context, listen: false).fetchWeather());
  }

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);
    final city = weatherProvider.city;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Consumer<WeatherProvider>(builder: (context, provider, _) {
        if (provider.weatherData == null) {
          return const Center(child: CircularProgressIndicator());
        } else {
          final weatherData = provider.weatherData;
          return Stack(
            children: [
              BackgroundWidget(weatherData: weatherData),
              Center(
                child: Column(
                  children: [
                    // Weather Icon, name, description, temperature
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(34),
                        color: Colors.white54,
                      ),
                      child: Row(
                        children: [
                          WeatherIconWidget(
                            iconUrl: '${weatherData!.icon}',
                            iconWidth: MediaQuery.of(context).size.width * 0.45,
                          ),
                          Column(
                            children: [
                              Text(
                                ' ${weatherData.temperature.truncate()}°',
                                style:
                                    TextStyleConst.temperatureLabelTextStyle2,
                              ),
                              Text(
                                StringHelper.capitalizeFirstLetters(
                                  ('${city!} - ') + weatherData.description,
                                ),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    //Description GridView
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              StringHelper.capitalizeFirstLetters(
                                ('$city - ') + weatherData.description,
                              ),
                            ),
                            Text(
                              StringHelper.capitalizeFirstLetters(
                                ('$city - ') + weatherData.description,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 22),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              StringHelper.capitalizeFirstLetters(
                                ('$city - ') + weatherData.description,
                              ),
                            ),
                            Text(
                              StringHelper.capitalizeFirstLetters(
                                ('${city} - ') + weatherData.description,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    //3-Days Weather Forecast
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: weatherProvider.weatherList.length,
                        itemBuilder: (context, index) {
                          final weather = weatherProvider.weatherList[index];
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Card(
                              child: Container(
                                width: 150,
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      weather.date
                                          .toIso8601String()
                                          .split('T')[0],
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      '${weather.temperature}°C',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(weather.description),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}
