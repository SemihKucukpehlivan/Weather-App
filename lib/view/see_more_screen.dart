import 'dart:ui';

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
                    const SizedBox(height: 20),
                    // Details
                    weatherDetails(city, weatherData),
                    const SizedBox(height: 20),
                    // Information
                    const SizedBox(height: 8),
                    forecastList(weatherProvider),
                  ],
                ),
              ),
            ],
          );
        }
      }),
    );
  }

  Padding weatherDetails(String? city, WeatherData? weatherData) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(), borderRadius: BorderRadius.circular(34)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(34),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 75, sigmaY: 75),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      _buildInformationWidget(
                          weatherData,
                          '${weatherData!.windSpeed}',
                          "Rüzgar",
                          Icons.wind_power_outlined,
                          'km/h'),
                      const SizedBox(
                        height: 8,
                      ),
                      _buildInformationWidget(
                          weatherData,
                          '${weatherData.humidity}',
                          "Nem",
                          Icons.water_drop,
                          '%'),
                    ],
                  ),
                  Column(
                    children: [
                      _buildInformationWidget(
                          weatherData,
                          '${weatherData.windSpeed}',
                          "Rüzgar",
                          Icons.wind_power_outlined,
                          'km/h'),
                      const SizedBox(
                        height: 8,
                      ),
                      _buildInformationWidget(
                          weatherData,
                          '${weatherData.humidity}',
                          "Nem",
                          Icons.water_drop,
                          "%"),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInformationWidget(WeatherData? weatherData, String value,
      String title, IconData icon, String text) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 25,
            ),
            const SizedBox(width: 3),
            Text(
              title,
              style: TextStyleConst.informationLabelTextStyle,
            ),
          ],
        ),
        Row(
          children: [
            Text(
              value,
              style: TextStyleConst.informationValueLabelTextStyle,
            ),
            const SizedBox(width: 3),
            Text(
              text,
              style: TextStyleConst.informationValueLabelTextStyle2,
            ),
          ],
        ),
      ],
    );
  }

  Container WheaterCard(
      WeatherData? weatherData, BuildContext context, String? city) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(34),
        color: Colors.white38,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(34),
        child: BackdropFilter(
          filter:
              ImageFilter.blur(sigmaX: 400, sigmaY: 400), // Apply blur effect
          child: Row(
            children: [
              WeatherIconWidget(
                iconUrl: '${weatherData!.icon}',
                iconWidth: MediaQuery.of(context).size.width * 0.50,
              ),
              Column(
                children: [
                  Text(
                    ' ${weatherData.temperature.truncate()}°',
                    style: TextStyleConst.temperatureLabelTextStyle,
                  ),
                  Text(
                      StringHelper.capitalizeFirstLetters(
                        (city!),
                      ),
                      style: TextStyleConst.cityLabelTextStyle),
                  Text(
                      StringHelper.capitalizeFirstLetters(
                        (weatherData.description),
                      ),
                      style: TextStyleConst.descriptionLabelTextStyle2),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget forecastList(
    WeatherProvider weatherProvider,
  ) {
    // Assuming the weatherProvider.weatherList contains at least 3 items
    return SizedBox(
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(3, (index) {
          //Progress Indicator ekle
          final weather = weatherProvider.weatherList[index];
          final formattedDate = formatDate(weather.date);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.29,
              decoration: BoxDecoration(
                color: Colors.white38,
                borderRadius: BorderRadius.circular(34),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  WeatherIconWidget(iconUrl: '${weather.icon}', iconWidth: 55),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(formattedDate,
                        style: TextStyleConst.formattedDate),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${weather.temperature}°C',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    StringHelper.capitalizeFirstLetters(
                      weather.description,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

String formatDate(DateTime date) {
  String day = date.day
      .toString()
      .padLeft(2, '0'); // Gün değeri, iki haneli olacak şekilde
  String month = date.month
      .toString()
      .padLeft(2, '0'); // Ay değeri, iki haneli olacak şekilde
  return '$day-$month';
}
