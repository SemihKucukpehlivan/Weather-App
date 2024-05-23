import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/view/constants/text_style_const.dart';
import 'package:weather_app/view/helper/format_date.dart';
import 'package:weather_app/view/helper/string_helper.dart';
import 'package:weather_app/view/weather_welcom_screen.dart';
import 'package:weather_app/view/widgets/background.dart';
import 'package:weather_app/view/widgets/global_button.dart';
import 'package:weather_app/view/widgets/weather_icon.dart';

class WeatherDetailsScreen extends StatefulWidget {
  const WeatherDetailsScreen({super.key});

  @override
  State<WeatherDetailsScreen> createState() => _WeatherDetailsScreenState();
}

class _WeatherDetailsScreenState extends State<WeatherDetailsScreen> {
  @override
  void initState() {
    super.initState();
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
                    const SizedBox(height: 20),
                    MainElevatedButton(
                      txt: "Return to Home Page",
                      widget: WeatherScreen(),
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
        border: Border.all(),
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
                      style: TextStyleConst.detailsScreenCityLabelTextStyle),
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
      height: 225,
      child: weatherProvider.weatherList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(3, (index) {
                //
                final weather = weatherProvider.weatherList[index];
                final formattedDayAndMonth =
                    FormatDate.formatDayAndMonth(weather.date);
                final formattedWeekday = FormatDate.formatWeekday(weather.date);
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.29,
                    decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all()),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(formattedWeekday,
                                        style: TextStyleConst
                                            .formattedDateLabelTextStyle),
                                    Text(formattedDayAndMonth,
                                        style: TextStyleConst
                                            .formattedDateTextStyle),
                                  ],
                                ),
                              ),
                              WeatherIconWidget(
                                iconUrl: '${weather.icon}',
                                iconWidth: 75,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${weather.temperature.truncate()}°C',
                                style:
                                    TextStyleConst.forecastTemperatureTextStyle,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                StringHelper.capitalizeFirstLetters(
                                  weather.description,
                                ),
                                maxLines: 1,
                                style:
                                    TextStyleConst.forecastDescriptionTextStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
    );
  }
}
