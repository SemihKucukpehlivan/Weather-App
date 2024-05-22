import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
                padding: const EdgeInsets.symmetric(vertical: 65),
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
          border: Border.all(),
          borderRadius: BorderRadius.circular(34),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(34),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 75, sigmaY: 75),
            child: _buildInformationWidget(weatherData),
          ),
        ),
      ),
    );
  }

  Widget _buildInformationWidget(WeatherData? weatherData) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildWeatherInfo(
            icon: Icons.wind_power,
            value: '${weatherData!.windSpeed}',
            unit: ' km/h',
            label: 'Wind Speed',
          ),
          _buildWeatherInfo(
            icon: Icons.water_drop_outlined,
            value: '${weatherData.humidity}',
            unit: ' %',
            label: 'Humidity',
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherInfo({
    required IconData icon,
    required String value,
    required String unit,
    required String label,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, size: 55),
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(value,
                        style: TextStyleConst.informationValueLabelTextStyle),
                    if (unit.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 7),
                        child: Text(unit,
                            style:
                                TextStyleConst.informationValueLabelTextStyle2),
                      ),
                  ],
                ),
                Text(label, style: TextStyleConst.informationLabelTextStyle),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Container WheaterCard(
    WeatherData? weatherData,
    BuildContext context,
    String? city,
  ) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(34),
        color: Colors.white38,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(34),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 400, sigmaY: 400),
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
