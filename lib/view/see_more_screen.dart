import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/model/weather_model.dart';
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 35),
                child: Column(
                  children: [
                    // Weather Icon, name, description, temperature
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: WheaterCard(weatherData, context, city),
                    ),
                    // Description GridView (consider revising or removing if not necessary)
                    Expanded(
                      child: WheaterDetails(city, weatherData),
                    ),

                    ForecastList(weatherProvider),
                  ],
                ),
              ),
            ],
          );
        }
      }),
    );
  }

  Padding WheaterDetails(String? city, WeatherData? weatherData) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildInformationWidget(
                  weatherData, '${weatherData!.windSpeed}', "Wind")
            ],
          )
        ],
      ),
    );
  }

  Expanded _buildInformationWidget(
      WeatherData? weatherData, String value, String title) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24), color: Colors.white54),
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.wind_power_outlined),
                    Text(
                      title,
                      style: const TextStyle(fontSize: 25),
                    ),
                  ],
                ),
                Text('$value km/h')
              ],
            )),
      ),
    );
  }

  Container WheaterCard(
      WeatherData? weatherData, BuildContext context, String? city) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(34),
        color: Colors.white38,
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
                style: TextStyleConst.temperatureLabelTextStyle2,
              ),
              Text(
                StringHelper.capitalizeFirstLetters(
                  (city!),
                ),
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                StringHelper.capitalizeFirstLetters(
                  (weatherData.description),
                ),
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Expanded ForecastList(WeatherProvider weatherProvider) {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: weatherProvider.weatherList.length,
        itemBuilder: (context, index) {
          final weather = weatherProvider.weatherList[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              width: 150,
              decoration: BoxDecoration(
                color: Colors.white38,
                borderRadius: BorderRadius.circular(34),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    weather.date.toIso8601String().split('T')[0],
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
          );
        },
      ),
    );
  }
}
